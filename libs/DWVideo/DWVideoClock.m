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

@implementation DWVideoClock 

@synthesize videoStartTime = _videoStartTime;
@synthesize asset;
@synthesize player;

-(id)initWithPlayer:(AVPlayer*)aPlayer andURLAsset:(AVURLAsset*)anAsset {
	DWTimeCodeType type;
	double frameRate = 0;
	

	DWFrame timeStameFrame = 0;
	
	for (AVAssetTrack * track in [anAsset tracks]) {
		if ([[track mediaType] isEqualToString:AVMediaTypeVideo]) {
			frameRate = track.nominalFrameRate;
		}		
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
								timeStameFrame = (timeStameFrame << 8) + buffer[i];
							}
							
							free(buffer);
						}
						
						CFRelease(sampleBuffer);
					}
					
					if (count == 0) {
						NSLog(@"I am doomed %@", [assetReader error]);
						exit(1);
					}
					
					NSLog(@"Processed %d sample", count);
					
				}
				
			}
			
			if ([assetReader status] != AVAssetReaderStatusCompleted)
				[assetReader cancelReading];
		}
	}

	
	DWLog(@"framerate = %.2f", frameRate);

	if (frameRate < 24) {
		type = kDWTimeCode2398;
	}
	else if (frameRate < 25) {
		type = kDWTimeCode24;
	}
	else if (frameRate == 25) {
		type = kDWTimeCode25;
	}
	else {
		type = kDWTimeCode2997;
	}

	self = [super initWithType:type];

	_videoStartTime = timeStameFrame * self.timePerFrame;

	asset = anAsset;
	player = aPlayer;

	// TODO
//	DWLog(@"timescale = %@", [player. attributeForKey:QTMovieTimeScaleAttribute]);
//	[movie setAttribute:[NSNumber numberWithLong:DWTIMESCALE] forKey:QTMovieTimeScaleAttribute];
//	DWLog(@"timescale = %@", [movie attributeForKey:QTMovieTimeScaleAttribute]);
	
	[player addPeriodicTimeObserverForInterval:CMTimeMake(1, 25) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
		self.rate = player.rate;
		self.time = self.videoStartTime + player.currentTime.value * DWTIMESCALE / player.currentTime.timescale;
	}];


	return self;
}

/*
-(DWTime)timeFromCMTime:(CMTime)cmtime {
	
	return cmtime.value + self.videoStartTime;
}

-(CMTime)qttimeFromTime:(DWTime)time {
	return CMTimeMake(time - self.videoStartTime, DWTIMESCALE);
}
*/
@end
