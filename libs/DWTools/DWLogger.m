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
	BOOL _showThread, _showFile, _showFunc, _showLine, _showDate;
	NSDateFormatter *dateFormatter;
}

-(id)init {
	self = [super init];
	level = kDWLogLevelBasic;
	output = stdout;
	currentLogFileName = nil;
	_showThread = NO;
	_showFile = NO;
	_showFunc = YES;
	_showLine = YES;
	_showDate = YES;
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


-(void)configureDisplay:(BOOL)showDate showTime:(BOOL)showTime showThread:(BOOL)showThread showFile:(BOOL)showFile showFunc:(BOOL)showFunc showLine:(BOOL)showLine {
	_showDate = showDate || showTime;
	
	if (showDate && showTime) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
	}
	else if (showDate) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	}
	else if (showTime) {
		[dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
	}
	_showThread = showThread;
	_showFile = showFile;
	_showFunc = showFunc;
	_showLine = showLine;
}

+(void)configureDisplay:(BOOL)showDate showTime:(BOOL)showTime showThread:(BOOL)showThread showFile:(BOOL)showFile showFunc:(BOOL)showFunc showLine:(BOOL)showLine {
	[[DWLogger singleton] configureDisplay:showDate showTime:showTime showThread:showThread showFile:showFile showFunc:showFunc showLine:showLine];	
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
		
		if (_showLine) {
			msg = [NSString stringWithFormat:@"(%3d) %@", line, msg];
		}
		
		if (_showFunc) {
			msg = [NSString stringWithFormat:@"%30s %@", funcName, msg];
		}
		
		if (_showFile) {
			msg = [NSString stringWithFormat:@"%15@ %@", [[NSString stringWithUTF8String:fileName] lastPathComponent], msg];
		}
		
		if (_showThread) {
			NSThread * thread = [NSThread currentThread];
			NSString * name = [thread name];
			if (name == nil) {
				name = [thread description];
			}
			msg = [NSString stringWithFormat:@"%@ %@", name, msg];
		}
		
		if (_showDate) {
			msg = [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]], msg];
		}
		
		fprintf(output, "%s\n", [msg UTF8String]);
	}
}

@end
