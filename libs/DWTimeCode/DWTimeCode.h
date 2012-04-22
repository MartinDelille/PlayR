//
//  DWTimeCode.h
//  DWTimeCode
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWTime.h"

/** 
 Type for the timecode frame.
 */
typedef long DWFrame;

/** Different type of timecode
 
 Enumerate the different type of timecode supported by the system.
 */
typedef enum {
	kDWTimeCode2398,
	kDWTimeCode24,
	kDWTimeCode25,
	kDWTimeCode2997,
} DWTimeCodeType;

/** Handles the timecode representation.
 
 Provide method for dealing with the timecode representation.
 */
@interface DWTimeCode : NSObject

/** 
 Type of timecode.
 */
@property(readonly) DWTimeCodeType type;
/** 
 Dropframe usage
 */
@property(readonly) BOOL drop;
/**
 Integral number of frame per second
 */
@property(readonly) long fps;
/** 
 Frame number from 00:00:00:00
 */
@property DWFrame frame;
/** 
 String representation of the timecode HH:MM:SS:FF
 */
@property NSString* string;
/** 
 Binary coded decimal representation of the timecode 0xHHMMSSFF
 */
@property unsigned int bcd;

/** 
 Initialize a timecode with a type
 @param aType A DWTimeCodeType value
 @return An initialized DWTimeCode object.
 */
-(id)initWithType:(DWTimeCodeType)aType;

/** 
 Initialize a timecode with a frame number and a type
 @param frame A frame number.
 @param aType A DWTimeCodeType value.
 @return An initialized DWTimeCode object.
 */
-(id)initWithFrame:(DWFrame)frame andType:(DWTimeCodeType)aType;

/** 
 Initialize a timecode with a string number and a type
 @param string A string.
 @param aType A DWTimeCodeType value.
 @return An initialized DWTimeCode object.
 */
-(id)initWithString:(NSString*)string andType:(DWTimeCodeType)aType;

@end
