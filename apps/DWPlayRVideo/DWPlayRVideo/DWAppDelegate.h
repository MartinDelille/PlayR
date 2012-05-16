//
//  DWAppDelegate.h
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWVideo/DWVideoView.h"

@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet DWVideoView *videoView;
@property (unsafe_unretained) IBOutlet NSPanel *controlPanel;
@property (weak) IBOutlet NSTextField *currentTCText;

- (IBAction)rewind:(id)sender;
- (IBAction)reversePlay:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)fastForward:(id)sender;

@end
