//
//  DWClock.m
//  DWClocking
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClock.h"

@implementation DWClock {
	DWTimeCodeType _type;
}

@synthesize time;
@synthesize rate;
@synthesize lastTickDate = _lastTickDate;

-(id)init {
	self = [super init];
	time = 0;
	_type = kDWTimeCode25;
	rate = 0.0;
	_lastTickDate = [NSDate dateWithTimeIntervalSince1970:0];
	return self;
}

-(id)initWithType:(DWTimeCodeType)aType {
	self = [self init];
	_type = aType;
	return self;
}

-(DWTimeCodeType)type {
	return _type;
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

-(void)tick:(DWTime)interval {
	self.time += (DWTime)(rate * interval);
	_lastTickDate = [NSDate date];
}

-(void)tickFrame {
	[self tick:[self timePerFrame]];
}

@end
