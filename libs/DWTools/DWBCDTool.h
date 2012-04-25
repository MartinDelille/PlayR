//
//  DWBCDTool.h
//  DWTools
//
//  Created by Martin Delille on 25/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWBCDTool : NSObject

/** 
 Compute the binary coded decimal value of an integer.
 @param i An integer value
 @return A BCD value
 */
+(unsigned int)bcdFromUInt:(unsigned int)i;

/** 
 Compute the integer value of a binary coded decimal value.
 @param i An BCD value
 @return An integer value
 */
+(unsigned int)uintFromBcd:(unsigned int)bcd;
  
@end
