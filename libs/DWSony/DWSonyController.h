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
	unsigned char status[8];
}

/** 
 Initialize a sony controller
 @param bsdPath Path to the serial port
 @param aClock DWClock synchronized by the sony controller
 @return A valid DWSonyController object.
 */
-(id)initWithClock:(DWClock*)aClock andRef:(NSString*)ref;

-(double)computeRateWithData1:(unsigned char)data1;

-(double)computeRateWithData1:(unsigned char)data1 andData2:(unsigned char)data2;

-(unsigned char)computeData1WithRate:(double)rate;

-(unsigned char)statusAtIndex:(int)index;

@end
