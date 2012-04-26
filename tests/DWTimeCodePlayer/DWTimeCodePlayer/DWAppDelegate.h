//
//  DWAppDelegate.h
//  DWTimeCodePlayer
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWClocking/DWClock.h"

/** Main DWTimeCodePlayer controller
 
 Link a clock componend to a display.
 Possibility to adjust the clock with buttons (play, stop, ...).
 */
@interface DWAppDelegate : NSObject <NSApplicationDelegate>

/** 
 The main clock component
 */
@property DWClock * clock;

/** 
 The main window.
 */
@property (assign) IBOutlet NSWindow *window;
/** 
 The current tc text field.
 */
@property (weak) IBOutlet NSTextField *tcText;

/** 
 Stop the clock
 @param sender User interface element which sent the message.
 @return N/A
 */
- (IBAction)stop:(id)sender;
/** 
 Put the clock in play mode
 @param sender User interface element which sent the message.
 @return N/A
 */
- (IBAction)play:(id)sender;
/** 
 Set the clock one frame ahead.
 @param sender User interface element which sent the message.
 @return N/A
 */
- (IBAction)nextFrame:(id)sender;
/** 
 Set the clock one frame back.
 @param sender User interface element which sent the message.
 @return N/A
 */
- (IBAction)previousFrame:(id)sender;
/** 
 Put the clock in rewind mode
 @param sender User interface element which sent the message.
 @return N/A
 */
- (IBAction)rewind:(id)sender;
/** 
 Put the clock in fast forward mode
 @param sender User interface element which sent the message.
 @return N/A
 */
- (IBAction)fastForward:(id)sender;

@end
