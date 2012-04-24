//
//  DWClock.m
//  DWClocking
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClock.h"

@implementation DWClock
@synthesize time;
@synthesize rate;

-(id)init {
	self = [super init];
	time = 0;
	rate = 0.0;
	return self;
}

-(void)dealloc {
	NSLog(@"dealloc dwclock");
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%d@%f", time, rate];
}

-(void)tick:(DWTime)interval {
	time += (DWTime)(rate * interval);
}
@end
