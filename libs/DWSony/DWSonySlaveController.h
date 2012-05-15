//
//  DWSonySlaveController.h
//  DWSony
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"


/** Slave controller for sony communication
 
 Handles the command from a connected sony master device 
 and update a clock component accordingly.
 */
@interface DWSonySlaveController : DWSonyController

/** 
 Initialize a sony slave controller with a clock.
 The controller connect automatically with the first 
 usb serial connected port referenced as "A"
 @param aClock A clock
 @return An initialized sony slave controller.
 */
-(id)initWithClock:(DWClock *)aClock;

/** 
 Start the thread handling the communication.
 */
-(void)start;

/** 
 Stop the thread handling the communication.
 */
-(void)stop;

/** 
 Process a single command and respond to it, updating the clock if needed.
 
 */
-(void)processCommand;

@end
