//
//  DWSonyController.h
//  DWSony
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWClock.h"

/** Controller for sony communication
 
 DWSonyController allows to update a clock component according
 to a sony serial port connected to a master.
 */
@interface DWSonyController : NSObject

/** 
 Initialize a sony controller
 @param bsdPath Path to the serial port
 @param aClock DWClock synchronized by the sony controller
 @return A valid DWSonyController object.
 */
-(id)initWithClock:(DWClock*)aClock;

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
