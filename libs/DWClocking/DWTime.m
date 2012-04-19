//
//  DWTime.m
//  DWClocking
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTime.h"

@implementation DWTime
@synthesize Time;
@synthesize Scale;

-(id)init {
	self = [super init];
	Scale = 1000;
	return self;
}

-(id)initWithScale:(long)scale {
	self = [super init];
	Scale = scale;
	return self;
}

-(id)initWithTime:(long)time andScale:(long)scale {
	self = [self initWithScale:scale];
	Time = time;
	return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%d/%d", Time, Scale];
}
@end
