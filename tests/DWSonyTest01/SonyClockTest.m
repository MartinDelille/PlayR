//
//  SonyClockTest.m
//  DWSonyTest01
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "SonyClockTest.h"

@implementation SonyClockTest {
	NSDate * firstTickDate;
	NSDate * lastTickDate;
	int tickCount;
}

-(id)init{
	self = [super init];
	firstTickDate = nil;
	lastTickDate = nil;
	tickCount = 0;
	return self;
}

-(void)tick{
	if (firstTickDate == nil) {
		firstTickDate = [NSDate date];
	}
	tickCount++;
	NSDate* current = [NSDate date];
	NSTimeInterval int1 = [current timeIntervalSinceDate:firstTickDate];
	NSTimeInterval int2 = [current timeIntervalSinceDate:lastTickDate];
	NSLog(@"$$$$$$ %f\t%f", int2, int1/tickCount);
	lastTickDate = current;
}

@end
