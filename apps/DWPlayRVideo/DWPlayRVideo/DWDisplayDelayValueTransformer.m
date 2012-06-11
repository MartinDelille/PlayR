//
//  DWDisplayDelayValueTransformer.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 11/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWDisplayDelayValueTransformer.h"

@implementation DWDisplayDelayValueTransformer

+(Class)transformedValueClass {
	return [NSNumber class];
}

+(BOOL)allowsReverseTransformation {
	return YES;
}

-(double)multiplier {
	NSString * unit = [[NSUserDefaults standardUserDefaults] stringForKey:@"DWPlayRDelayUnit"];
	if ([unit isEqualToString:@"ms"]) {
		return 1000;
	}
	else if ([unit isEqualToString:@"quarter frames"]) {
		return 100;
	}
	return 1;
}

-(id)transformedValue:(id)value {
	return [NSNumber numberWithDouble:[value doubleValue] * [self multiplier]];
}

-(id)reverseTransformedValue:(id)value {
	return [NSNumber numberWithDouble:[value doubleValue] / [self multiplier]];
}

@end
