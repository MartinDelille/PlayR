//
//  DWSonySlaveController.h
//  DWSony
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"

@interface DWSonySlaveController : DWSonyController


@property BOOL useSonySync;

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
