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
@property long Time;
/** 
 Amount of time unit per second.
 */
@property long Scale;

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
-(id)initWithTime:(long)time andScale:(long)scale;
@end
