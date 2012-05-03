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
 Inform about the 
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
/** /Users/martindelille/Dropbox/code/PlayR/tests/DWSonyMasterTest01/DWSonyMasterTest01/DWAppDelegate.h
 The current timecode text field
 */
@property (weak) IBOutlet NSTextField *currentTCText;

/** 
 Display the status data.
 */
@property (weak) IBOutlet NSTextField *currentStatusText;

/** 
 Toggle the sync source between internal and sony.
 */
@property BOOL useInternaleSync;

/** 
 Display the sync quality.
 */
@property (weak) IBOutlet NSTextField *txtSyncState;

@end
