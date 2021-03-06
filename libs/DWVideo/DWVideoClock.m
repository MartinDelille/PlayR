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
#import "DWFourCCToStringTransformer.h"

@implementation DWVideoClock {
	DWTime _videoStartTime, _lastTime;
	AVURLAsset * _asset;
	AVPlayer * _player;
	AVPlayerItem * _playerItem;
}

@synthesize url;
@synthesize state;
@synthesize videoFrameRate;
@synthesize videoResolution;
@synthesize videoCodec;

-(AVPlayer*)player {
	return _player;
}

-(id)init {
	self = [super init];
	self.state = kDWVideoClockStateNotReady;
	_player = [[AVPlayer alloc] init];
	
	return self;
}

-(void)dealloc {
	DWLog(@"");
}

-(BOOL)loadWithUrl:(NSURL *)anUrl {
	self.rate = 0;

	// TODO: check if AVURLAssetPreferPreciseDurationAndTimingKey is needed
	self.url = anUrl;
	NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
	_asset = [[AVURLAsset alloc] initWithURL:anUrl options:options];
	
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
									   self.url = nil;
									   // TODO : handle error and cancelation
									   break;
							   }
						   });
		}];
		return YES;
	}
	else {
		return NO;
	}	
}

-(void)assetDidLoad {	
	for (AVAssetTrack * track in [_asset tracks]) {
		if ([[track mediaType] isEqualToString:AVMediaTypeVideo]) {
			self.videoResolution = track.naturalSize;
			CMVideoFormatDescriptionRef format = (__bridge CMFormatDescriptionRef)[track.formatDescriptions objectAtIndex:0];
			self.videoCodec = CMVideoFormatDescriptionGetCodecType(format);
			DWLog(@"codec: %@", [DWFourCCToStringTransformer stringWithFourCC:self.videoCodec]);

			if (track.nominalFrameRate != 0) {
				self.videoFrameRate = track.nominalFrameRate;
			}
			else {
				// if the nominalFrameRate is not specified, compute the framerate from the first sample duration
				AVAssetReader *assetReader = [AVAssetReader assetReaderWithAsset:_asset error:nil];
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
							
							CMSampleTimingInfo timingInfo;
							CMSampleBufferGetSampleTimingInfo(sampleBuffer, 0, &timingInfo);
							//	DWLog(@"reading sample %d: %lld / %d", count, timingInfo.duration.value, timingInfo.duration.timescale);
							self.videoFrameRate = (float)timingInfo.duration.timescale / timingInfo.duration.value;
							
							CFRelease(sampleBuffer);
							break;
						}
						
						if (count == 0) {
							//DWLog(@"No sample in the track: %@", [assetReader error]);
						}
					}
					
				}
				
				if ([assetReader status] != AVAssetReaderStatusCompleted)
					[assetReader cancelReading];

			}
		}
	}

	DWLog(@"framerate = %.2f", self.videoFrameRate);

	if (self.videoFrameRate == 0) {
		DWLog(@"Bad framerate value");
		return;
	}
	else if (self.videoFrameRate < 23.99) { // check if the framerate is within the interval [0 - 23.99]
		self.type = kDWTimeCode2398;
	}
	else if (self.videoFrameRate < 24.5) { // check if the framerate is within the interval [23.99 - 24.5]
		self.type = kDWTimeCode24;
	}
	else if (self.videoFrameRate < 25.5) { // check if the framerate is within the interval [24.5 - 25.5]
		self.type = kDWTimeCode25;
	}
	else {
		self.type = kDWTimeCode2997; // check if the framerate is greater than 25.5
	}

	_playerItem = [AVPlayerItem playerItemWithAsset:_asset];

	// TODO
	
	//	[playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
	
	/*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];*/
//	_player = [AVPlayer playerWithPlayerItem:_playerItem];
	[_player replaceCurrentItemWithPlayerItem:_playerItem];

	[self willChangeValueForKey:@"timeStampString"];
	[self willChangeValueForKey:@"originalTimeStampString"];
	_videoStartTime = self.timePerFrame * self.originalTimeStampFrame;
	[self didChangeValueForKey:@"timeStampString"];
	[self didChangeValueForKey:@"originalTimeStampString"];

	self.state = kDWVideoClockStateReady;
	self.time = _videoStartTime;
	__block DWVideoClock * blockSafeSelf = self;

	[self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 50) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
		if (self.time != super.time) {
			[blockSafeSelf willChangeValueForKey:@"time"];
			[blockSafeSelf willChangeValueForKey:@"visibleTimecodeString"];
			super.time = blockSafeSelf.time;
			[blockSafeSelf didChangeValueForKey:@"time"];
			[blockSafeSelf didChangeValueForKey:@"visibleTimecodeString"];
		}
	}];
}

-(DWTime)videoDelayCompensationTime {
	NSTimeInterval videoDelayCompensation = [[NSUserDefaults standardUserDefaults] doubleForKey:@"DWVideoDelayCompensation"];
	return videoDelayCompensation * DWTIMESCALE * self.rate;
}

-(void)setTime:(DWTime)time {
	[self willChangeValueForKey:@"visibleTimecodeString"];
	[super setTime:time];
	if (state == kDWVideoClockStateReady) {
		[_player seekToTime:CMTimeMake(time - _videoStartTime + [self videoDelayCompensationTime], DWTIMESCALE)];
	}
	[self didChangeValueForKey:@"visibleTimecodeString"];
	if(time!=_lastTime)
	{
		DWLog([self visibleTimecodeString]);
		_lastTime = time;
	}
}

-(DWTime)time {
	if ((state == kDWVideoClockStateReady) && (self.currentReference == nil)) {
		return _player.currentTime.value * DWTIMESCALE / _player.currentTime.timescale + _videoStartTime - [self videoDelayCompensationTime];
	}
	else {
		return super.time;
	}
}

-(NSString*)visibleTimecodeString {
	return [DWTimeCode stringFromFrame:(self.frame + [self videoDelayCompensationTime] / self.timePerFrame) andType:self.type];
}

-(void)setRate:(double)rate {
	[super setRate:rate];
	if ((state == kDWVideoClockStateReady) && (self.currentReference == nil)) {
		// TODO : handle delay compensation
		_player.rate = rate;
	}
}

-(double)rate {
	if ((state == kDWVideoClockStateReady) && (self.currentReference == nil)) {
		return _player.rate;
	}
	else {
		return [super rate];
	}
}

-(DWFrame)originalTimeStampFrame {
	DWFrame timeStampFrame = 0;
	for (AVAssetTrack * track in [_asset tracks]) {
		if ([[track mediaType] isEqualToString:AVMediaTypeTimecode]) {
			AVAssetReader *assetReader = [AVAssetReader assetReaderWithAsset:_asset error:nil];
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
							unsigned char *buffer = (unsigned char*)malloc(length);
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
						DWLog(@"No timetimestame information in the track: %@", [assetReader error]);
					}
					
					DWLog(@"timestamp extracted: %d", timeStampFrame);
					
				}
				
			}
			
			if ([assetReader status] != AVAssetReaderStatusCompleted)
				[assetReader cancelReading];
		}
	}
	return timeStampFrame;
}

-(NSString *)originalTimeStampString {
	return [DWTimeCode stringFromFrame:self.originalTimeStampFrame andType:self.type];
}

-timeStampString {
	DWFrame videoStartFrame = _videoStartTime / self.timePerFrame;
	return [DWTimeCode stringFromFrame:videoStartFrame andType:self.type];
}

-(void)updateTimestampWithCurrentTimecodeString:(NSString *)currentTCString {
	DWFrame newCurrentFrame = [DWTimeCode frameFromString:currentTCString andType:self.type];
	DWTime newCurrentTime = newCurrentFrame * self.timePerFrame;
	DWTime oldCurrentTime = self.time;
	
	[self willChangeValueForKey:@"time"];
	[self willChangeValueForKey:@"timeStampString"];
	_videoStartTime += newCurrentTime - oldCurrentTime;
	[self didChangeValueForKey:@"time"];
	[self didChangeValueForKey:@"timeStampString"];
	
	self.time = newCurrentTime;

}
@end
