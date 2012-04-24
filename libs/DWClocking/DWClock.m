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
	DWTime _time;
}

@synthesize rate;

-(id)init {
	self = [super init];
	_time = 0;
	_type = kDWTimeCode25;
	rate = 0.0;
	return self;
}

-(id)initWithType:(DWTimeCodeType)aType {
	self = [self init];
	_type = aType;
	return self;
}

-(DWTime)timePerFrame {
	switch (_type) {
		case kDWTimeCode2398:
			return DWTC2398FRAMEDURATION;
		case kDWTimeCode24:
			return DWTC24FRAMEDURATION;
		case kDWTimeCode25:
			return DWTC25FRAMEDURATION;
		case kDWTimeCode2997:
			return DWTC2997FRAMEDURATION;
		default:
			[NSException raise:@"Invalid timecode type" format:@"type is not a valid DWTimeCodeType : %d", _type];
			return 0;
	}
}

-(void)setTime:(DWTime)time {
	if(_time != time)
	{
		_time = time;
		// TODO: notify observer
	}
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
	self.frame = [DWTimeCode frameFromString:tcString andType:_type];
}

-(NSString *)tcString {
	return [DWTimeCode stringFromFrame:self.frame andType:_type];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%d@%f", time, rate];
}

-(void)tick:(DWTime)interval {
	self.time += (DWTime)(rate * interval);
}
@end
