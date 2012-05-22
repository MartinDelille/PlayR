//
//  DWFourCCToStringTransformer.h
//  DWTools
//
//  Created by Martin Delille on 21/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWFourCCToStringTransformer : NSValueTransformer

+(NSString*)stringWithFourCC:(FourCharCode)code;

@end
