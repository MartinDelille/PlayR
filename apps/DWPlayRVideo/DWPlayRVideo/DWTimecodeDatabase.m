//
//  DWTimecodeDatabase.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 23/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimecodeDatabase.h"

@implementation DWTimecodeDatabase

+(NSString *)timecodeForURL:(NSURL *)url {
	NSDictionary * dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"DWTimecodeDatabase"];
	
	if (dict != nil) {
		return [dict objectForKey:[url absoluteString]];
	}
	else {
		return nil;
	}
}

+(void)storeTimecode:(NSString *)tc forURL :(NSURL *)url {
	NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"DWTimecodeDatabase"]];
	[dict setObject:tc forKey:[url absoluteString]];
	[[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"DWTimecodeDatabase"];
}

+(void)clear {
	[[NSUserDefaults standardUserDefaults] setNilValueForKey:@"DWTimecodeDatabase"];
}

@end
