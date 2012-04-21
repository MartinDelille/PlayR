//
//  DWTime.h
//  DWClocking
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Time model
 
 Provide a representation of a time value
 */
@interface DWTime : NSObject

/** 
 Amount of time since the time origin 0 according to its scale.
 */
@property unsigned int time;
/** Amount of time unit per second. */
@property unsigned int scale;

/** Amout of hours since the time origne 0 (floor rounding) */
@property(readonly) unsigned int hh;

/** Amout of minutes since the time origne 0 (floor rounding) */
@property(readonly) unsigned int mm;

/** Amout of secondes since the time origne 0 (floor rounding) */
@property(readonly) unsigned ss;

/** 
 Initialize the object with a scale value
 @param scale to use.
 @return The object instance.
 */
-(id)initWithScale:(long)scale;
/** 
 Initialize the object with a time and a scale value
 @param time to use.
 @param scale to use.
 @return The object instance.
 */
-(id)initWithTime:(long)t andScale:(long)s;
@end
