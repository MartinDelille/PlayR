//
//  DWVideoClock.m
//  DWVideo
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideoClock.h"
#import "DWTools/DWLogger.h"
#import "DWClocking/DWTimeCode.h"

@implementation DWVideoClock {
	DWTime _videoStartTime;
	AVURLAsset * _asset;
	AVPlayer * _player;
	AVPlayerItem * _playerItem;
}

@synthesize currentFrame;
@synthesize state;

-(AVPlayer*)player {
	return _player;
}

-(id)init {
	self = [super init];
	self.state = kDWVideoClockStateNotReady;
	
	return self;
}

-(id)initWithUrl:(NSURL *)url {
	self = [self init];
	
	// TODO: check if AVURLAssetPreferPreciseDurationAndTimingKey is needed
	NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
	_asset = [[AVURLAsset alloc] initWithURL:url options:options];
	
	if (_asset != nil) {
		NSArray *keys = [NSArray arrayWithObject:@"tracks"];
		
		self.state = kDWVideoClockStateLoading;
		[_asset loadValuesAsynchronouslyForKeys:keys completionHandler:^() {
			dispatch_async(dispatch_get_main_queue(),
						   ^{
							   AVKeyValueStatus trackStatus = [_asset statusOfValueForKey:@"tracks" error:nil];
							   DWLog(@"state : %d", trackStatus);
							   switch (trackStatus) {
								   case AVKeyValueStatusLoaded:
									   [self assetDidLoad];
									   break;
								   case AVKeyValueStatusFailed:
									   //[self reportError:*outError onAsset:asset];
								   case AVKeyValueStatusCancelled:
									   self.state = kDWVideoClockStateNotReady;
									   // TODO : handle error and cancelation
									   break;
							   }
						   });
		}];
		return self;
	}
	else {
		return nil;
	}	
}


-(void)assetDidLoad {	
	double frameRate = [DWVideoClock extractVideoFrameRate:_asset];
	
	DWLog(@"framerate = %.2f", frameRate);

	if (frameRate == 0) {
		DWLog(@"Bad framerate value");
		return;
	}
	else if (frameRate < 24) {
		self.type = kDWTimeCode2398;
	}
	else if (frameRate < 25) {
		self.type = kDWTimeCode24;
	}
	else if (frameRate == 25) {
		self.type = kDWTimeCode25;
	}
	else {
		self.type = kDWTimeCode2997;
	}

	_playerItem = [AVPlayerItem playerItemWithAsset:_asset];

	// TODO
	
	//	[playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
	
	/*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];*/
	_player = [AVPlayer playerWithPlayerItem:_playerItem];

	
	self.currentFrame = self.frame;
	_videoStartTime = self.timePerFrame * [DWVideoClock extractTimeStamp:_asset];

	self.state = kDWVideoClockStateReady;

	__block DWFrame lastCurrentFrame = -1;
	[self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 50) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
		if (self.frame != lastCurrentFrame) {
			lastCurrentFrame = self.currentFrame = self.frame;
		}
	}];
	

}

-(void)setTime:(DWTime)time {
	if (state == kDWVideoClockStateReady) {
		[_player seekToTime:CMTimeMake(time - _videoStartTime, DWTIMESCALE)];
	}
}

-(DWTime)time {
	if (state == kDWVideoClockStateReady) {
		return _player.currentTime.value * DWTIMESCALE / _player.currentTime.timescale + _videoStartTime;
	}
	else {
		return 0;
	}
}

-(void)setRate:(double)rate {
	if (state == kDWVideoClockStateReady) {
		_player.rate = rate;
	}
}

-(double)rate {
	if (state == kDWVideoClockStateReady) {
		return _player.rate;
	}
	else {
		return 0;
	}
}

+(double)extractVideoFrameRate:(AVAsset*)anAsset {
	for (AVAssetTrack * track in [anAsset tracks]) {
		if ([[track mediaType] isEqualToString:AVMediaTypeVideo]) {
			return track.nominalFrameRate;
		}
	}
	return 0;
}

+(DWFrame)extractTimeStamp:(AVAsset*)anAsset {
	DWFrame timeStampFrame = 0;
	for (AVAssetTrack * track in [anAsset tracks]) {
		if ([[track mediaType] isEqualToString:AVMediaTypeTimecode]) {
			AVAssetReader *assetReader = [AVAssetReader assetReaderWithAsset:anAsset error:nil];
			AVAssetReaderTrackOutput *assetReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:track outputSettings:nil]; 
			if ([assetReader canAddOutput:assetReaderOutput]) {
				[assetReader addOutput:assetReaderOutput];
				if ([assetReader startReading] == YES) {
					int count = 0;
					
					while ( [assetReader status]==AVAssetReaderStatusReading ) {
						CMSampleBufferRef sampleBuffer = [assetReaderOutput copyNextSampleBuffer];
						if (sampleBuffer == NULL) {
							if ([assetReader status] == AVAssetReaderStatusFailed) 
								break;
							else    
								continue;
						}
						count++;
						
						CMBlockBufferRef blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
						size_t length = CMBlockBufferGetDataLength(blockBuffer);
						
						if (length>0) {
							unsigned char *buffer = malloc(length);
							memset(buffer, 0, length);
							CMBlockBufferCopyDataBytes(blockBuffer, 0, length, buffer);
							
							for (int i=0; i<length; i++) {
								timeStampFrame = (timeStampFrame << 8) + buffer[i];
							}
							
							free(buffer);
						}
						
						CFRelease(sampleBuffer);
					}
					
					if (count == 0) {
						DWLog(@"No sample in the timecode track: %@", [assetReader error]);
					}
					
					DWLog(@"Processed %d sample", count);
					
				}
				
			}
			
			if ([assetReader status] != AVAssetReaderStatusCompleted)
				[assetReader cancelReading];
		}
	}
	return timeStampFrame;
}

@end
