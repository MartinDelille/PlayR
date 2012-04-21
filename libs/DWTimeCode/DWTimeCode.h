//
//  DWTimeCode.h
//  DWTimeCode
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWTime.h"

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
@interface DWTimeCode : DWTime

@property(readonly) DWTimeCodeType type;
@property(readonly) BOOL drop;
@property(readonly) unsigned int fps;

@property unsigned int frame;
@property NSString* string;
@property unsigned int bcd;

-(void)setHh:(unsigned int)hh Mm:(unsigned int)mm Ss:(unsigned int)ss Ff:(unsigned int)ff;
-(void)getHh:(unsigned int*)hh Mm:(unsigned int*)mm Ss:(unsigned int*)ss Ff:(unsigned int*)ff;

-(id)initWithType:(DWTimeCodeType)aType;
-(id)initWithFrame:(unsigned int)frame andType:(DWTimeCodeType)aType;

@end
