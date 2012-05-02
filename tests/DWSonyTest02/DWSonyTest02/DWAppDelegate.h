//
//  DWAppDelegate.h
//  DWSonyTest02
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/** Main DWSonyTest02 controller
 
 Link the clock to a sony controller and the display.
 Start and stop the sony controller.
 */
@interface DWAppDelegate : NSObject <NSApplicationDelegate>

/** 
 The main window
 */
@property (assign) IBOutlet NSWindow *window;
/** 
 The current rate text field
 */
@property (weak) IBOutlet NSTextField *currentRateText;
/** 
 The current timecode text field
 */
@property (weak) IBOutlet NSTextField *currentTCText;
@end
