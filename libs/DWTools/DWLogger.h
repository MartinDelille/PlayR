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
	kDWLogLevelSonyDetails1 = 1 << 9,
	kDWLogLevelSonyDetails2 = 1 << 10,
} DWLogLevel;

/** Custom logger class
 
 Provide advanced control over the output log.
 */
@interface DWLogger : NSObject

/** 
 Singleton instance of the class
 @return The DWLogger singleton instance.
 */
+(DWLogger*)singleton;

/** 
 Configure the log level, allowing to filter which information are logged
 @param aLevel A DWLogLevel mask
 */
+(void)configureLogLevel:(DWLogLevel)aLevel;
/** 
 Allow to redirect the output to a file.
 @param fileName path to the file
 */
+(void)configureOutput:(NSString*)fileName;

/** 
 Configure the output option for the log.
 @param showDate Show the current date
 @param showTime Show the current time
 @param showFile Show the file from which the log is performed
 @param showFunc Show the function from which the log is performed
 @param showLine Show the line number from which the log is performed
 */
+(void)configureDisplay:(BOOL)showDate showTime:(BOOL)showTime showFile:(BOOL)showFile showFunc:(BOOL)showFunc showLine:(BOOL)showLine;

/** 
 Log a message to the log output
 @param aLevel Log level, allowing filtering according to the current log level mask
 @param fileName File from which the log is performed
 @param line Line from which the log is performed
 @param funcName Function from which the log is performed
 @param msg Message to be logged
 */
-(void)log:(DWLogLevel)aLevel fileName:(const char *)fileName line:(int)line funcName:(const char *)funcName message:(NSString *)msg, ...;

@end
