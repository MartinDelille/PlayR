//
//  DWSonyController.h
//  DWSony
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWClock.h"
#import "DWSonyPort.h"

/** Controller for sony communication
 
 DWSonyController allows to update a clock component according
 to a sony serial port connected to a master.
 */
@interface DWSonyController : NSObject {
@protected
	DWClock * clock;
	DWSonyPort * port;
	unsigned char buffer[256];
}

/** 
 Initialize a sony controller
 @param bsdPath Path to the serial port
 @param aClock DWClock synchronized by the sony controller
 @return A valid DWSonyController object.
 */
-(id)initWithClock:(DWClock*)aClock andRef:(NSString*)ref;

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

-(double)computeSpeedWithData1:(unsigned char)data1;

-(double)computeSpeedWithData1:(unsigned char)data1 andData2:(unsigned char)data2;

@end
