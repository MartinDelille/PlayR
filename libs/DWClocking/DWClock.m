//
//  DWClock.m
//  DWClocking
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClock.h"

@implementation DWClock {
	DWTime _time;
}


@synthesize rate;
@synthesize type;
@synthesize lastTickDate = _lastTickDate;
@synthesize currentReference;

-(id)init {
	self = [super init];
	_time = 0;
	self.type = kDWTimeCode25;
	rate = 0.0;
	_lastTickDate = [NSDate dateWithTimeIntervalSince1970:0];
	currentReference = nil;
	return self;
}

-(DWTime)timePerFrame {
	switch (self.type) {
		case kDWTimeCode2398:
			return DWTC2398FRAMEDURATION;
		case kDWTimeCode24:
			return DWTC24FRAMEDURATION;
		case kDWTimeCode25:
			return DWTC25FRAMEDURATION;
		case kDWTimeCode2997:
			return DWTC2997FRAMEDURATION;
	}
}

-(void)setTime:(DWTime)time {
	[self performSelectorOnMainThread:@selector(willChangeValueForKey:) withObject:@"frame" waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(willChangeValueForKey:) withObject:@"tcString" waitUntilDone:YES];
	_time = time;
	[self performSelectorOnMainThread:@selector(didChangeValueForKey:) withObject:@"frame" waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(didChangeValueForKey:) withObject:@"tcString" waitUntilDone:YES];
}

-(DWTime)time {
	return _time;
}

-(void)setFrame:(DWFrame)frame {
	self.time = frame * [self timePerFrame];
}

-(DWFrame)frame {
	return self.time / [self timePerFrame];
}

-(void)setTcString:(NSString *)tcString {
	self.frame = [DWTimeCode frameFromString:tcString andType:self.type];
}

-(NSString *)tcString {
	return [DWTimeCode stringFromFrame:self.frame andType:self.type];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@@%f", self.tcString, rate];
}

-(void)tick:(id)sender withInterval:(DWTime)interval {
	if (sender == currentReference) {
		self.time += (DWTime)(rate * interval);
		_lastTickDate = [NSDate date];
	}
}

-(void)tickFrame:(id)sender {
	[self tick:sender withInterval:[self timePerFrame]];
}

@end
