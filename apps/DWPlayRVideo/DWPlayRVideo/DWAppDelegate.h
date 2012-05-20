//
//  DWAppDelegate.h
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWPlayRVideoView.h"
#import "DWVideo/DWVideoClock.h"

@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet DWPlayRVideoView *videoView;
@property (unsafe_unretained) IBOutlet NSPanel *controlPanel;
@property (weak) IBOutlet NSTextField *currentTCText;
@property (weak) IBOutlet DWVideoClock *clock;


- (IBAction)rewind:(id)sender;
- (IBAction)reversePlay:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)fastForward:(id)sender;

- (IBAction)playPause;

-(void)showControlPanel;
-(void)showControlPanelAndHide;
-(void)hideControlPanel;
//- (IBAction)showFileProperties:(id)sender;

@end
