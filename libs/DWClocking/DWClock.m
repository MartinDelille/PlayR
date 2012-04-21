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
@synthesize timePerTick;

-(id)init {
	self = [super init];
	time = [[DWTime alloc] init];
	timePerTick = [[DWTime alloc] init];
	return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@@%@", time, timePerTick];
}

-(void)tick {
	time.time += timePerTick.time;
}
@end
