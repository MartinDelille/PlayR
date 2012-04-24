//
//  DWLogger.h
//  DWTools
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DWLog2(args) [[DWLogger singleton] log:kDWLogLevelBasic fileName:__FILE__ line:__LINE__ funcName:__PRETTY_FUNCTION__ message:args];
#define DWLog(args...) [[DWLogger singleton] log:kDWLogLevelBasic fileName:__FILE__ line:__LINE__ funcName:__PRETTY_FUNCTION__ message:args];

#define DWLogWithLevel(level, args...) [DWLogger log:legel fileName:__FILE__ line:__LINE__ funcName:__PRETTY_FUNCTION__ message:args);

typedef enum {
	kDWLogLevelBasic = 1,
	kDWLogLevelTest = 2,
	kDWLogLevelSonyBasic = 1 << 8,
} DWLogLevel;

@interface DWLogger : NSObject

+(DWLogger*)singleton;
+(void)configureLogLevel:(DWLogLevel)aLevel;
-(void)configureOutput:(NSString *)fileName;
+(void)configureOutput:(NSString*)fileName;
-(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ...;

//+(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ...;

@end
