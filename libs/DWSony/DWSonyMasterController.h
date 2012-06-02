//
//  DWSonyMasterController.h
//  DWSony
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"

/** Master controller for sony communication
 
 Send command to a connected sony slave device 
 and update a clock component and the status accordingly.
 */
@interface DWSonyMasterController : DWSonyController

/** 
 Initialize a sony master controller.
 The controller connect automatically with the first 
 usb serial connected port referenced as "B"
 @return An initialized sony master controller.
 */
-(id)init;

/** 
 Send a play command to the connected device.
 */
-(void)play;

/** 
 Send a stop command to the connected device.
 */
-(void)stop;

/** 
 Send a fast forward command to the connected device.
 */
-(void)fastForward;

/** 
 Send a rewind command to the connected device.
 */
-(void)rewind;

/** 
 Send a jog command to the connected device.
 @param rate The jog rate
 */
-(void)jog:(double)rate;

/** 
 Send a varispeed command to the connected device.
 @param rate The varispeed rate
 */
-(void)varispeed:(double)rate;

/** 
 Send a shuttle command to the connected device.
 @param rate The shuttle rate
 */
-(void)shuttle:(double)rate;

/** 
 Send a time sense command to the connected device.
 */
-(void)timeSense;

/** 
 Send a status sense command to the connected device.
 */
-(void)statusSense;

@end
