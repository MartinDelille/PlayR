//
//  DWLogger.m
//  DWTools
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWLogger.h"

static DWLogger * _singleton;

@implementation DWLogger {
	DWLogLevel level;
	FILE * output;
}

-(id)init {
	self = [super init];
	level = kDWLogLevelBasic;
	output = stdout;
	return self;
}

+(DWLogger *)singleton {
	if (_singleton == nil) {
		_singleton = [[DWLogger alloc] init];
	}
	return _singleton;
}

-(void)configureLogLevel:(DWLogLevel)aLevel {
	level = aLevel;
}

+(void)configureLogLevel:(DWLogLevel)aLevel {
	[[DWLogger singleton] configureLogLevel:aLevel];
}

-(void)configureOutput:(NSString *)fileName {
	FILE * f = fopen([fileName UTF8String], "a");
	if (f!=nil) {
		output = f;
	}
}

+(void)configureOutput:(NSString *)fileName {
	[[DWLogger singleton] configureOutput:fileName];	
}

-(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ... {
	
	va_list ap;
	va_start (ap, msg);
	msg = [[NSString alloc] initWithFormat:msg arguments:ap];
	va_end (ap);

	NSString *fileName2=[[NSString stringWithUTF8String:fileName] lastPathComponent];

	msg = [NSString stringWithFormat:@"%@ %30s:%3d - %@", fileName2, funcName, line, msg];
	
	// TODO : ... filter by class name ...
	
	fprintf(output, "%s\n", [msg UTF8String]);
}

@end
