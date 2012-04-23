//
//  DWClock.h
//  DWClocking
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTime.h"
#import "DWTickable.h"

/** Mother class for clock component.
 
 This class is the base class for clock system.
 */
@interface DWClock : NSObject<DWTickable>

/** 
 Current clock time.
 */
@property DWTime time;

/**
 Current clock time.
 */
@property double rate;

/** 
 Tell to the clock that an interval of elapsed time.
 @param interval Amount of elapsed time.
 */
-(void)tick:(DWTime)interval;

@end
