//
//  DWFourCCToStringTransformer.m
//  DWTools
//
//  Created by Martin Delille on 21/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWFourCCToStringTransformer.h"

@implementation DWFourCCToStringTransformer

+(Class)transformedValueClass {
	return [NSString class];
}

+(BOOL)allowsReverseTransformation {
	return NO;
}

+(NSString*)stringWithFourCC:(FourCharCode)code {
	char c[5];
	c[0] = code >> 24;
    c[1] = (code >> 16) & 0xff;
    c[2] = (code >> 8) & 0xff;
    c[3] = code & 0xff;
    c[4] = '\0';
	
    return  [NSString stringWithUTF8String:c];
}

-(id)transformedValue:(id)value {
	return [DWFourCCToStringTransformer stringWithFourCC:[value intValue]];
}

@end
