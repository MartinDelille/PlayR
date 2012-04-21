//
//  DWTime.m
//  DWClocking
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTime.h"

@implementation DWTime
@synthesize time;
@synthesize scale;

-(long)hh {
	return self.mm / 60;
}

-(long)mm {
	return self.ss / 60;
}

-(long)ss {
	return time / scale;
}

-(id)init {
	self = [super init];
	scale = 24000;
	return self;
}

-(id)initWithScale:(long)s {
	self = [super init];
	scale = s;
	return self;
}

-(id)initWithTime:(long)t andScale:(long)s {
	self = [self initWithScale:scale];
	time = t;
	return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"DWTime %d/%d", time, scale];
}
@end
