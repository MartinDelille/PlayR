//
//  DWVideoClock.h
//  DWVideo
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClocking/DWClock.h"
#import <AVFoundation/AVFoundation.h>

typedef enum {
	kDWVideoClockStateNotReady,
	kDWVideoClockStateLoading,
	kDWVideoClockStateReady,
} DWVideoClockState;

@interface DWVideoClock : DWClock

@property(readonly) DWTime videoStartTime;
@property AVURLAsset * asset;
@property AVPlayer * player;
@property AVPlayerItem * playerItem;
@property DWFrame currentFrame;
@property DWVideoClockState state;

-(id)initWithUrl:(NSURL*)url;

@end
