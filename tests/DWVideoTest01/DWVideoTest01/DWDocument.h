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

@class DWVideoTestView;

/** Document controller for a single video file
 
 Create the video clock object.
 Handles the user interface control command (play, pause, ...)
 */
@interface DWDocument : NSDocument

/**
 The document window
 */
@property (strong) IBOutlet NSWindow *mainWindow;
/** 
 The document main view
 */
@property (unsafe_unretained) IBOutlet DWVideoTestView *mainView;
/** 
 The control panel
 */
@property (strong) IBOutlet NSPanel *controlPanel;
/** 
 The text field displaying the current timecode
 */
@property(retain) IBOutlet NSTextField *txtCurrentTC;
/** 
 The video clock.
 */
@property(retain) DWVideoClock * clock;

/** 
 Play the video.
 @param sender The message sender
 @return N/A
 */
- (IBAction)play:(id)sender;
/** 
 Pause the video.
 @param sender The message sender
 @return N/A
 */
- (IBAction)pause:(id)sender;
/** 
 Fast forward the video.
 @param sender The message sender
 @return N/A
 */
- (IBAction)fastForward:(id)sender;
/** 
 Play the video backward.
 @param sender The message sender
 @return N/A
 */
- (IBAction)reverse:(id)sender;
/** 
 Rewind the video.
 @param sender The message sender
 @return N/A
 */
- (IBAction)rewind:(id)sender;

/** 
 Toggle the video between play and pause
 */
-(void)playPause;

/** 
 Play the video at variable rate
 @param delta A rate increment value
 */
-(void)shuttle:(double)delta;

@end
