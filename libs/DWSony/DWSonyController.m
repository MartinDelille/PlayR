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

@synthesize clock;

-(id)initWithRef:(NSString*)ref {
	self = [super init];
	port = [[DWSonyPort alloc] initWithRef:ref];
	if (port == nil) {
		DWSonyLog(@"Sony port unavailable");
		return nil;
	}

	clock = nil;

	return self;
}


-(double)computeRateWithData1:(unsigned char)data1 {
	double n1 = data1;
	return pow(10, n1/32 - 2);
}

-(double)computeRateWithData1:(unsigned char)data1 andData2:(unsigned char)data2 {
	double n1 = data1;
	double n2 = data2;
	double rate = [self computeRateWithData1:data1];
	return rate + n2/256 * pow(10, (n1+1)/32 - 2 - rate);
}

-(unsigned char)computeData1WithRate:(double)rate {
	return (unsigned char)(32*(2+log10(rate)));
}

-(unsigned char)statusAtIndex:(int)index {
	return status[index];
}

@end
