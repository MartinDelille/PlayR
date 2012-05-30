//
//  DWVideoClock.h
//  DWVideo
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClocking/DWClock.h"
#import <AVFoundation/AVFoundation.h>

/** Video clock state
 
 Define the various video clock state.
 */
typedef enum {
	/** Video clock not ready */
	kDWVideoClockStateNotReady,
	/** Video clock loading the data from the URL */
	kDWVideoClockStateLoading,
	/** Video clock ready for playback */
	kDWVideoClockStateReady,
} DWVideoClockState;


/** The video clock
 
 DWVideoClock allow to load a video file from an URL for video playback.
 It allows control of the rate and current time.
 */
@interface DWVideoClock : DWClock

/** 
 Load a video file at an URL.
 @param url An URL to a video file.
 @return YES if the loading is triggered (witch doesn't mean that the file is
 effectively loaded: observe "state" property to know the result).
 */
-(BOOL)loadWithUrl:(NSURL*)url;

@property NSURL* url;

/** 
 AVPlayer corresponding to the video clock.
 */
@property(readonly) AVPlayer * player;
/** 
 Current state of the video clock.
 */
@property DWVideoClockState state;

@property double videoFrameRate;

@property NSSize videoResolution;

@property FourCharCode videoCodec;

@property(readonly) NSString * timeStampString;

@property(readonly) DWFrame originalTimeStampFrame;
@property(readonly) NSString * originalTimeStampString;

@property (readonly) NSString * visibleTimecodeString;

-(void)updateTimestampWithCurrentTimecodeString:(NSString*)currentTCString;

@end
