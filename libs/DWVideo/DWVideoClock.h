//
//  DWVideoClock.h
//  DWVideo
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClocking/DWClock.h"
#import <AVFoundation/AVFoundation.h>

@interface DWVideoClock : DWClock

@property(readonly) DWTime videoStartTime;
@property AVURLAsset * asset;
@property AVPlayer * player;

-(id)initWithPlayer:(AVPlayer*)aPlayer andURLAsset:(AVURLAsset*)anAsset;

@end
