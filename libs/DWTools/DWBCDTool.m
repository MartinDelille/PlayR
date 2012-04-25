//
//  DWBCDTool.m
//  DWTools
//
//  Created by Martin Delille on 25/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWBCDTool.h"

@implementation DWBCDTool
+(unsigned int)bcdFromUInt:(unsigned int)i {
	unsigned int result = 0;
	unsigned int n = 0;
	while (i > 0) {
		result += (i % 10) << n;
		i = i/10;
		n += 4;
	}
	return result;
}

+(unsigned int)uintFromBcd:(unsigned int)bcd {
	unsigned int result = 0;
	unsigned int n = 1;
	while (bcd > 0) {
		result += (bcd & 0xf) * n;
		n = n * 10;
		bcd = bcd >> 4;
	}
	return result;
}
@end
