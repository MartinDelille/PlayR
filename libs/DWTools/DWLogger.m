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
	NSString * currentLogFileName;
	FILE * output;
	BOOL logShowFile, logShowFunc, logShowDate;
	NSDateFormatter *dateFormatter;
}

-(id)init {
	self = [super init];
	level = kDWLogLevelBasic;
	output = stdout;
	currentLogFileName = nil;
	logShowFile = NO;
	logShowFunc = YES;
	logShowDate = YES;
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
	
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
	if(fileName == nil)
	{
		if (currentLogFileName != nil)
		{
			fclose(output);
			currentLogFileName = nil;
			output = stdout;
		}
	}
	else {
		FILE * f = fopen([fileName UTF8String], "a");
		if (f!=nil) {
			output = f;
			currentLogFileName = fileName;
		}
	}
}

+(void)configureOutput:(NSString *)fileName {
	[[DWLogger singleton] configureOutput:fileName];	
}


-(void)configure:(DWLogLevel)aLevel fileName:(NSString *)fileName showDate:(BOOL)showDate showTime:(BOOL)showTime showFile:(BOOL)showFile showFunc:(BOOL)showFunc {
	[self configureLogLevel:aLevel];
	[self configureOutput:fileName];
	
	logShowDate = showDate || showTime;
	
	if (showDate && showTime) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
	}
	else if (showDate) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	}
	else if (showTime) {
		[dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
	}
	logShowFile = showFile;
	logShowFunc = showFunc;
}

+(void)configure:(DWLogLevel)aLevel fileName:(NSString *)fileName showDate:(BOOL)showDate showTime:(BOOL)showTime showFile:(BOOL)showFile showFunc:(BOOL)showFunc {
	[[DWLogger singleton] configure:aLevel fileName:fileName showDate:showDate showTime:showTime showFile:showFile showFunc:showFunc];	
}

-(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ... 
{
	DWLogLevel test = aLevel & level;
	if(test != 0)
	{
		va_list ap;
		va_start (ap, msg);
		msg = [[NSString alloc] initWithFormat:msg arguments:ap];
		va_end (ap);
		
		if (logShowFunc) {
			msg = [NSString stringWithFormat:@"%30s:%3d %@", funcName, line, msg];
		}
		
		if (logShowFile) {
			msg = [NSString stringWithFormat:@"%15s %@", [[NSString stringWithUTF8String:fileName] lastPathComponent], msg];
		}
		
		if (logShowDate) {
			msg = [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]], msg];
		}
		
		fprintf(output, "%s\n", [msg UTF8String]);
	}
}

@end
