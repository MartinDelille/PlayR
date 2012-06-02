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

/** Generic controller for sony communication
 
 Provide a generic implementation for handlind sony master 
 and slave communication.

 */
@interface DWSonyController : NSObject<DWBoolEventHandler> {
@protected
/** Sony serial port connected to the controller */
	DWSonyPort * port;
/** Sony controller status */
	unsigned char status[8];
}

/** Clock linked to the controller */
@property DWClock * clock;

/** 
 Initialize a sony controller
 @param ref USB serial port reference.
 @return A valid DWSonyController object.
 */
-(id)initWithRef:(NSString*)ref;

/** 
 Compute the rate from the jog, varispeed and shuttle sony protocole
 order data.
 For more detail see http://www.belle-nuit.com/archives/9pin.html#jogFwd
 @param data1 A one byte coded version of the rate.
 @return The float value corresponding rate.
 */
-(double)computeRateWithData1:(unsigned char)data1;

/** 
 Compute the rate from the jog, varispeed and shuttle sony protocole
 order data.
 For more detail see http://www.belle-nuit.com/archives/9pin.html#jogFwd
 @param data1 The first byte of the two bytes coded version of the rate.
 @param data2 The second byte of the two bytes coded version of the rate.
 @return The float value corresponding rate.
 */
-(double)computeRateWithData1:(unsigned char)data1 andData2:(unsigned char)data2;

/** 
 Compute the jog, varispeed and shuttle sony protocole
 order data from a rate
 For more detail see http://www.belle-nuit.com/archives/9pin.html#jogFwd
 @param rate The float value rate. 
 @return A one byte coded version of the rate.
 */
-(unsigned char)computeData1WithRate:(double)rate;

/** 
 Get an element of the device status.
 For more detail see http://www.belle-nuit.com/archives/9pin.html#statusData
 @param index Index of the status array
 @return A 8 bit status information
 */
-(unsigned char)statusAtIndex:(int)index;

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
-(void)processCmd1:(unsigned char)cmd1 andCmd2:(unsigned char)cmd2 withData:(const unsigned char*)dataIn;

@end
