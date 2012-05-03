//
//  DWAppDelegate.h
//  DWSonyMasterTest01
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/** Main DWSonyMasterTest01 controller
 
 Link the clock to a sony controller and the display.
 Send command to the sony controller and retrieve time and status.

 */
@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *currentTCText;

/** 
 Display the status data.
 */
@property (weak) IBOutlet NSTextField *txtStatus0;

/** 
 Send a play command to the sony controller.
 @param sender The sender ui element.
 @return N/A
 */
- (IBAction)play:(id)sender;

/** 
 Send a stop command to the sony controller.
 @param sender The sender ui element.
 @return N/A
 */
- (IBAction)stop:(id)sender;

/** 
 Send a fast forward command to the sony controller.
 @param sender The sender ui element.
 @return N/A
 */
- (IBAction)fastForward:(id)sender;

/** 
 Send a jog rev command at nominal speed to the sony controller.
 @param sender The sender ui element.
 @return N/A
 */
- (IBAction)jogRev1x:(id)sender;

/** 
 Send a rewind command to the sony controller.
 @param sender The sender ui element.
 @return N/A
 */
- (IBAction)rewind:(id)sender;

@end
