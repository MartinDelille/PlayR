//
//  DWBCDTool.h
//  DWTools
//
//  Created by Martin Delille on 25/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>


/** BCD utility.
 
 Provides a tool from converting an integer from and to
 a binary coded decimal (BCD) value.
 */
@interface DWBCDTool : NSObject

/** 
 Compute the BCD value of an integer.
 @param i An integer value
 @return A BCD value
 */
+(unsigned int)bcdFromUInt:(unsigned int)i;

/** 
 Compute the integer value of a BCD value.
 @param bcd An BCD value
 @return An integer value
 */
+(unsigned int)uintFromBcd:(unsigned int)bcd;
  
@end
