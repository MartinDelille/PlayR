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

/**
 Amount of time per frame according to the timecode type.
 */
@property(readonly) DWTime timePerFrame;

/**
 Timecode representation of the current time
 */
@property NSString * tcString;

/** 
 Current reference for the clock (see tick message)
 */
@property id currentReference;

/** 
 If the message sender is the current reference of the clock, 
 the clock current time is computed according to the elapsed time.
 @param sender The message sender.
 @param interval Amount of elapsed time.
 */
-(void)tick:(id)sender withInterval:(DWTime)interval;

/** 
 If the message sender is the current reference of the clock, 
 the clock current time is computed according to an elapsed frame.
 @param sender The message sender.
 */
-(void)tickFrame:(id)sender;

/** 
 Get the date the last tick occured.
 */
@property(readonly) NSDate* lastTickDate;

@end
