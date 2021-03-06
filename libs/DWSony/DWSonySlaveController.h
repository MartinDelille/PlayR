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
 Initialize a sony slave controller.
 The controller connect automatically with the first 
 usb serial connected port referenced as "A"
 @return An initialized sony slave controller.
 */
-(id)init;

@end
