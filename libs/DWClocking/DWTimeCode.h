//
//  DWTimeCode.h
//  DWClocking
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

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

/** Timecode representation utility
 
 Provide tools for converting between frame, string representation and 
 BCD representation of a timecode value.
 */
@interface DWTimeCode : NSObject

/** 
 Create a timecode string representation from a frame number and a type
 @param frame A frame number.
 @param type A DWTimeCodeType value.
 @return An NSString* timecode representation.
 */
+(NSString*)stringFromFrame:(DWFrame)frame andType:(DWTimeCodeType)type;

/** 
 Compute the frame number from a timecode string representation and a type
 @param string A string.
 @param type A DWTimeCodeType value.
 @return The corresponding frame number.
 */
+(DWFrame)frameFromString:(NSString*)string andType:(DWTimeCodeType)type;

/** 
 Compute the frame number from a timecode binary coded decimal (BCD) representation and a type
 @param bcd A BCD value.
 @param type A DWTimeCodeType value.
 @return The corresponding frame number.
 */
+(DWFrame)frameFromBcd:(unsigned int)bcd andType:(DWTimeCodeType)type;

/** 
 Create a timecode BCD representation from a frame number and a type
 @param frame A frame number.
 @param type A DWTimeCodeType value.
 @return A timecode BCD representation.
 */
+(unsigned int)bcdFromFrame:(DWFrame)frame andType:(DWTimeCodeType)type;

/** 
 Compute the HH, MM, SS and FF timecode component from a frame number and a type.
 @param hh Hours output value
 @param mm Minutes output value
 @param ss Secondes output value
 @param ff Frame output value
 @param frame Frame number
 @param type Timecode typ
 */
+(void)ComputeHh:(unsigned int *)hh Mm:(unsigned int *)mm Ss:(unsigned int *)ss Ff:(unsigned int *)ff fromFrame:(DWFrame)frame andType:(DWTimeCodeType)type;

/** 
 Compute frame number from the HH, MM, SS and FF timecode component and a type.
 @param hh Hours output value
 @param mm Minutes output value
 @param ss Secondes output value
 @param ff Frame output value
 @param type Timecode typ
 @return A frame number
 */
+(DWFrame)frameFromHh:(unsigned int)hh Mm:(unsigned int)mm Ss:(unsigned int)ss Ff:(unsigned int)ff andType:(DWTimeCodeType)type;

@end
