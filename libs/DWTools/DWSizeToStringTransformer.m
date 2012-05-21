//
//  DWSiteToStringTransformer.m
//  DWTools
//
//  Created by Martin Delille on 21/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSizeToStringTransformer.h"

@implementation DWSizeToStringTransformer

+(Class)transformedValueClass {
	return [NSString class];
}

+(BOOL)allowsReverseTransformation {
	return NO;
}

-(id)transformedValue:(id)value {
	NSSize size = [value sizeValue];
	return [NSString stringWithFormat:@"%.0fx%.0f", size.width, size.height];
}

@end
