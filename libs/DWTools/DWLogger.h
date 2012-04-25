//
//  DWLogger.h
//  DWTools
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DWLog(args...) [[DWLogger singleton] log:kDWLogLevelBasic fileName:__FILE__ line:__LINE__ funcName:__PRETTY_FUNCTION__ message:args];
#define DWLogWithLevel(level, args...) [[DWLogger singleton] log:level fileName:__FILE__ line:__LINE__ funcName:__PRETTY_FUNCTION__ message:args];

typedef enum {
	kDWLogLevelBasic = 1,
	kDWLogLevelTest = 2,
	kDWLogLevelSonyBasic = 1 << 8,
	kDWLogLevelSonyDetails = 1 << 9,
} DWLogLevel;

@interface DWLogger : NSObject

+(DWLogger*)singleton;
+(void)configureLogLevel:(DWLogLevel)aLevel;
+(void)configureOutput:(NSString*)fileName;
+(void)configure:(DWLogLevel)aLevel fileName:(NSString*)fileName showDate:(BOOL)showDate showTime:(BOOL)showTime showFile:(BOOL)showFile showFunc:(BOOL)showFunc;
-(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ...;

//+(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ...;

@end
