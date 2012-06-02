//
//  DWString.m
//  DWTools
//
//  Created by Martin Delille on 02/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWString.h"

@implementation DWString

+(NSString *)stringWithBuffer:(const unsigned char *)buffer andLength:(int)length {
	NSString * result = @"";
	for (int i = 0; i < length; i++) {
		result = [NSString stringWithFormat:@"%@%.2X ", result, buffer[i]];
	}
	return result;
}
@end
