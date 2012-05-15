//
//  DWClock.h
//  DWClocking
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTime.h"
#import "DWTimeCode.h"

/** Mother class for clock component.
 
 This class is the base class for clock system.
 */
@interface DWClock : NSObject

/** 
 Current clock time.
 */
@property DWTime time;

/**
 Current clock time.
 */
@property double rate;

/** 
 Timecode type
 */
@property DWTimeCodeType type;

/**
 Current frame number according to the clock timecode type.
 */
@property DWFrame frame;

@property(readonly) DWTime timePerFrame;

/**
 Timecode representation of the current time
 */
@property NSString * tcString;

@property id currentReference;

/** 
 Tell to the clock that an interval of time has elapsed.
 @param interval Amount of elapsed time.
 */
-(void)tick:(id)sender withInterval:(DWTime)interval;

/** 
 Tell to the clock that a frame has elapsed.
 */
-(void)tickFrame:(id)sender;

/** 
 Get the date the last tick occured.
 */
@property(readonly) NSDate* lastTickDate;

@end
