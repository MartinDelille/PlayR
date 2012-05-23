//
//  DWTimecodeDatabase.h
//  DWPlayRVideo
//
//  Created by Martin Delille on 23/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWTimecodeDatabase : NSObject

+(NSString*)timecodeForURL:(NSURL*)url;
+(void)storeTimecode:(NSString*)tc forURL:(NSURL*)url;
+(void)clear;

@end
