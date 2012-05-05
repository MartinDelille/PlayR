//
//  DWDocument.h
//  DWVideoTest01
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import "DWVideo/DWVideoClock.h"
#import "DWVideoView.h"

@interface DWDocument : NSDocument
@property (unsafe_unretained) IBOutlet DWVideoView *videoView;

@property(retain) IBOutlet NSTextField *txtCurrentTC;

@property AVPlayer * player;
@property AVPlayerItem * playerItem;
@property(retain) DWVideoClock * clock;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)fastForward:(id)sender;
- (IBAction)reverse:(id)sender;
- (IBAction)rewind:(id)sender;

@end
