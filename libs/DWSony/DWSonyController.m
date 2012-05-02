//
//  DWSonyController.m
//  DWSony
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"
#import "DWTools/DWBCDTool.h"

@implementation DWSonyController

-(id)initWithClock:(DWClock *)aClock andRef:(NSString*)ref {
	self = [self init];
	port = [[DWSonyPort alloc] initWithRef:ref];
	if (port == nil) {
		DWSonyLog(@"Sony port unavailable");
		return nil;
	}

	clock = aClock;
	
	// TODO allow switch between internal and video reference
	port.videoRefDelegate = clock;
	
	return self;
}


-(double)computeSpeedWithData1:(unsigned char)data1 {
	double n1 = data1;
	return pow(10, n1/32 - 2);
}

-(double)computeSpeedWithData1:(unsigned char)data1 andData2:(unsigned char)data2 {
	double n1 = data1;
	double n2 = data2;
	double rate = [self computeSpeedWithData1:data1];
	return rate + n2/256 * pow(10, (n1+1)/32 - 2 - rate);
}

-(unsigned char)statusAtIndex:(int)index {
	return status[index];
}
@end
