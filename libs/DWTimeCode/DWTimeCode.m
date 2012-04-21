//
//  DWTimeCode.m
//  DWTimeCode
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimeCode.h"

@implementation DWTimeCode {
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

-(id)initWithFrame:(unsigned int)frame andType:(DWTimeCodeType)aType {
	self = [self initWithType:aType];
	self.frame = frame;
	return self;
}

+(BOOL)isDrop:(DWTimeCodeType)type {
	return type == kDWTimeCode2997;
}

+(unsigned int)getTimePerFrame:(DWTimeCodeType)type {
	switch (type) {
		case kDWTimeCode2398:
			return 1001;
		case kDWTimeCode24:
			return 1000;
		case kDWTimeCode25:
			return 960;
		case kDWTimeCode2997:
			return 801;
		default:
			[NSException raise:@"Invalid timecode type" format:@"type is not a valid DWTimeCodeType : %d", type];
			return 0;
	}
}

+(unsigned int)getFps:(DWTimeCodeType)type {
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

-(unsigned int)fps {
	return [DWTimeCode getFps:self.type];
}

-(BOOL)drop {
	return [DWTimeCode isDrop:self.type];
}

-(unsigned int)frame {
	return self.time / [DWTimeCode getTimePerFrame:self.type];
}

-(void)setFrame:(unsigned int)frame {
	self.time = frame * [DWTimeCode getTimePerFrame:self.type];
}

- (DWTimeCodeType)type {
	return type;
}

-(NSString *)string {
	unsigned int hh, mm, ss, ff;
	[self getHh:&hh Mm:&mm Ss:&ss Ff:&ff];
	return [NSString stringWithFormat:@"%02d:%02d:%02d:%02d", hh, mm, ss, ff];
}

-(void)setString:(NSString *)string {
	NSArray * list = [string componentsSeparatedByString:@":"];
	if (list.count != 4) {
		[NSException raise:@"Bad TC string" format:@"Bad TC string: %@", string];
	}
	else {
		unsigned int hh, mm, ss, ff;
		hh = [[list objectAtIndex:0] intValue];
		mm = [[list objectAtIndex:1] intValue];
		ss = [[list objectAtIndex:2] intValue];
		ff = [[list objectAtIndex:3] intValue];
		[self setHh:hh Mm:mm Ss:ss Ff:ff];
	}
}

-(void)setHh:(unsigned int)hh Mm:(unsigned int)mm Ss:(unsigned int)ss Ff:(unsigned int)ff {
	if ((hh<24) && (mm<60) && (ss<60) && (ff<self.fps)) {
		unsigned int dropframe = 0;
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

-(void)getHh:(unsigned int *)hh Mm:(unsigned int *)mm Ss:(unsigned int *)ss Ff:(unsigned int *)ff {
	unsigned int n = self.frame;
	
	// computing hour
	unsigned int framePerHour = 3600 * self.fps;
	if(self.drop)
		framePerHour -= 108;
	*hh = n / framePerHour;
	n = n % framePerHour;
	
	// computing tenth of minutes
	unsigned int framePerTenMinutes = 600 * self.fps;
	if(self.drop)
		framePerTenMinutes -= 18;
	*mm = 10 * (n / framePerTenMinutes);
	n = n % framePerTenMinutes;
	
	// computing minutes
	unsigned int framePerMinute = 60 * self.fps;
	if (n >= framePerMinute) {
		*mm += 1;
		n -= framePerMinute;
		
		if (self.drop)
			framePerMinute -= 2;
		
		*mm += n / framePerMinute;
		n = n % framePerMinute;
	}
	
	// computing seconds
	unsigned int framePerSecond = self.fps;
	
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
