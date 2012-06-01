//
//  DWInternalReference.m
//  DWClocking
//
//  Created by Martin Delille on 01/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWInternalReference.h"

@implementation DWInternalReference {
	NSTimer * timer;
}

@synthesize clock;
@synthesize interval;

-(id)init {
	self = [super init];
	
	self.interval = 1;
	
	return self;
}

-(id)initWithClock:(DWClock *)aClock {
	self = [super init];
	
	self.clock = aClock;
	self.interval = (NSTimeInterval)self.clock.timePerFrame / DWTIMESCALE;
	
	return self;
}

-(void)dealloc {
	[self stop];
}

-(void)tick {
	[self.clock tick:self withInterval:self.interval * DWTIMESCALE];
}

-(void)start {
	if (timer == nil) {
		timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(tick) userInfo:nil repeats:YES];
		
		NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
		[runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
	}
}

-(void)stop {
	if (timer != nil) {
		[timer invalidate];
		timer = nil;
	}
}

-(NSString *)description {
	return [NSString stringWithFormat:@"DWInternal reference (%f)", interval];
}

@end
