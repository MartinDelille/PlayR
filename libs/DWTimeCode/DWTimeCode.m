//
//  DWTimeCode.m
//  DWTimeCode
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimeCode.h"

@implementation DWTimeCode {
	DWTime time;
	DWTimeCodeType type;
}

-(id)init {
	self = [super init];
	type = kDWTimeCode25;
	
	return self;
}

-(id)initWithType:(DWTimeCodeType)aType {
	self = [self init];
	type = aType;
	
	return self;
}

-(id)initWithTime:(DWTime)aTime andType:(DWTimeCodeType)aType {
	self = [self initWithType:aType];
	time = aTime;
	return self;
}

-(id)initWithFrame:(DWFrame)aFrame andType:(DWTimeCodeType)aType {
	self = [self initWithType:aType];
	self.frame = aFrame;
	return self;
}

-(id)initWithString:(NSString *)string andType:(DWTimeCodeType)aType {
	self = [self initWithType:aType];
	self.string = string;
	return self;
}

+(BOOL)isDrop:(DWTimeCodeType)type {
	return type == kDWTimeCode2997;
}

+(DWTime)getTimePerFrame:(DWTimeCodeType)type {
	switch (type) {
		case kDWTimeCode2398:
			return 8008;
		case kDWTimeCode24:
			return 8000;
		case kDWTimeCode25:
			return 7680;
		case kDWTimeCode2997:
			return 6408;
		default:
			[NSException raise:@"Invalid timecode type" format:@"type is not a valid DWTimeCodeType : %d", type];
			return 0;
	}
}

+(DWFrame)getFps:(DWTimeCodeType)type {
	switch (type) {
		case kDWTimeCode2398:
		case kDWTimeCode24:
			return 24;
		case kDWTimeCode25:
			return 25;
		case kDWTimeCode2997:
			return 30;
		default:
			[NSException raise:@"Invalid timecode type" format:@"type is not a valid DWTimeCodeType : %d", type];
			return 0;
	}
}

-(long)fps {
	return [DWTimeCode getFps:self.type];
}

-(BOOL)drop {
	return [DWTimeCode isDrop:self.type];
}

-(DWFrame)frame {
	return time / [DWTimeCode getTimePerFrame:self.type];
}

-(void)setFrame:(DWFrame)frame {
	time = frame * [DWTimeCode getTimePerFrame:self.type];
}

- (DWTimeCodeType)type {
	return type;
}

-(NSString *)string {
	unsigned char hh, mm, ss, ff;
	[self getHh:&hh Mm:&mm Ss:&ss Ff:&ff];
	return [NSString stringWithFormat:@"%02d:%02d:%02d:%02d", hh, mm, ss, ff];
}

-(void)setString:(NSString *)string {
	NSArray * list = [string componentsSeparatedByString:@":"];
	if (list.count != 4) {
		[NSException raise:@"Bad TC string" format:@"Bad TC string: %@", string];
	}
	else {
		unsigned char hh, mm, ss, ff;
		hh = [[list objectAtIndex:0] intValue];
		mm = [[list objectAtIndex:1] intValue];
		ss = [[list objectAtIndex:2] intValue];
		ff = [[list objectAtIndex:3] intValue];
		[self setHh:hh Mm:mm Ss:ss Ff:ff];
	}
}

-(unsigned int)bcd {
	unsigned char hh, mm, ss, ff;
	unsigned int result;
	[self getHh:&hh Mm:&mm Ss:&ss Ff:&ff];
	
	result = ff % 10; 
	result += (ff/10) << 4;
	result += (ss % 10) << 8;
	result += (ss/10) << 12;
	result += (mm % 10) << 16; 
	result += (mm/10) << 20;
	result += (hh % 10) << 24;
	result += (hh/10) << 28;
	
	return result;
}

-(void)setBcd:(unsigned int)bcd {
	unsigned char hh, mm, ss, ff;
	
	hh = (bcd >> 28) * 10;
	hh += (bcd >> 24) & 0x0f;
	mm = ((bcd >> 20) & 0x0f) * 10;
	mm += (bcd >> 16) & 0x0f;
	ss = ((bcd >> 12) & 0x0f) * 10; 
	ss += (bcd >> 8) & 0x0f;
	ff = ((bcd >> 4) & 0x0f) * 10;
	ff += bcd & 0x0f;
	
	[self setHh:hh Mm:mm Ss:ss Ff:ff];
}

-(void)setHh:(unsigned char)hh Mm:(unsigned char)mm Ss:(unsigned char)ss Ff:(unsigned char)ff {
	if ((hh<24) && (mm<60) && (ss<60) && (ff<self.fps)) {
		DWFrame dropframe = 0;
		if (self.drop) {
			// counting drop per hour
			dropframe += hh * 108;
			// counting drop per tenth of minute
			dropframe += (mm/10) * 18;
			// counting drop per minute
			dropframe += (mm%10) * 2;
		}
		self.frame = (((hh * 60) + mm) * 60 + ss) * self.fps + ff - dropframe;								   
	}
	else {
		[NSException raise:@"Invalid timecode digit" format:@"Digit are not valid %02d:%02d:%02d:%02d", hh, mm, ss, ff];
	}
}

-(void)getHh:(unsigned char *)hh Mm:(unsigned char *)mm Ss:(unsigned char *)ss Ff:(unsigned char *)ff {
	DWFrame n = self.frame;
	
	// computing hour
	DWFrame framePerHour = 3600 * self.fps;
	if(self.drop)
		framePerHour -= 108;
	*hh = n / framePerHour;
	n = n % framePerHour;
	
	// computing tenth of minutes
	DWFrame framePerTenMinutes = 600 * self.fps;
	if(self.drop)
		framePerTenMinutes -= 18;
	*mm = 10 * (n / framePerTenMinutes);
	n = n % framePerTenMinutes;
	
	// computing minutes
	DWFrame framePerMinute = 60 * self.fps;
	if (n >= framePerMinute) {
		*mm += 1;
		n -= framePerMinute;
		
		if (self.drop)
			framePerMinute -= 2;
		
		*mm += n / framePerMinute;
		n = n % framePerMinute;
	}
	
	// computing seconds
	DWFrame framePerSecond = self.fps;
	
	if (self.drop && (*mm % 10 > 0)) {
		if (n < framePerSecond - 2) {
			*ss = 0;
			n += 2;
		}
		else {
			*ss = 1 + (n - framePerSecond + 2) / framePerSecond;
			n = (n - framePerSecond + 2) % framePerSecond;
		}
	}
	else {
		*ss = n / framePerSecond;
		n = n % framePerSecond;
	}
	
	*ff = n;	
}

-(NSString *)description {
	return self.string;
}

@end
