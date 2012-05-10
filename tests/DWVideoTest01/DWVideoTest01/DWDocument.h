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

@class DWVideoView;
@class DWMainView;

@interface DWDocument : NSDocument
@property (unsafe_unretained) IBOutlet DWVideoView *videoView;
@property (unsafe_unretained) IBOutlet DWMainView *mainView;
@property (strong) IBOutlet NSPanel *controlPanel;
@property (strong) IBOutlet NSWindow *mainWindow;

@property(retain) IBOutlet NSTextField *txtCurrentTC;

@property(retain) DWVideoClock * clock;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)fastForward:(id)sender;
- (IBAction)reverse:(id)sender;
- (IBAction)rewind:(id)sender;

-(void)playPause;
-(void)shuttle:(double)delta;

@end
