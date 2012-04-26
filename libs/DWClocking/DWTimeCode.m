//
//  DWTimeCode.m
//  DWClocking
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimeCode.h"

@implementation DWTimeCode

+(NSString *)stringFromFrame:(DWFrame)frame andType:(DWTimeCodeType)type {
	unsigned int hh, mm, ss, ff;
	[DWTimeCode ComputeHh:&hh Mm:&mm Ss:&ss Ff:&ff fromFrame:frame andType:type];
	return [NSString stringWithFormat:@"%@%02d:%02d:%02d:%02d", (frame<0)?@"-":@"", hh, mm, ss, ff];
}

+(DWFrame)frameFromString:(NSString *)string andType:(DWTimeCodeType)type {
	long sign = 1;
	if ((string.length > 0) && [string characterAtIndex:0] == '-') {
		sign = -1;
		string = [string substringFromIndex:1];
	}
	NSArray * list = [string componentsSeparatedByString:@":"];
	unsigned int hhmmssff[4];
	memset(hhmmssff, 0, 4 * sizeof(unsigned int));
	
	for (int i=0; i<MIN(4, list.count); i++) {
		DWLog(@"%d : %@", i, [list objectAtIndex:i]);
		int k = i;
		if(list.count < 4)
			k += 4 - list.count;
		hhmmssff[k] = [[list objectAtIndex:i] intValue];
	}
	return sign * [DWTimeCode frameFromHh:hhmmssff[0] Mm:hhmmssff[1] Ss:hhmmssff[2] Ff:hhmmssff[3] andType:type];
}

+(unsigned int)bcdFromFrame:(DWFrame)frame andType:(DWTimeCodeType)type {
	unsigned int hh, mm, ss, ff;
	unsigned int result;
	[DWTimeCode ComputeHh:&hh Mm:&mm Ss:&ss Ff:&ff fromFrame:frame andType:type];
	
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

+(DWFrame)frameFromBcd:(unsigned int)bcd andType:(DWTimeCodeType)type {
	unsigned int hh, mm, ss, ff;
	
	hh = (bcd >> 28) * 10;
	hh += (bcd >> 24) & 0x0f;
	mm = ((bcd >> 20) & 0x0f) * 10;
	mm += (bcd >> 16) & 0x0f;
	ss = ((bcd >> 12) & 0x0f) * 10; 
	ss += (bcd >> 8) & 0x0f;
	ff = ((bcd >> 4) & 0x0f) * 10;
	ff += bcd & 0x0f;
	
	return [DWTimeCode frameFromHh:hh Mm:mm Ss:ss Ff:ff andType:type];
}

+(BOOL)isDrop:(DWTimeCodeType)type {
	return type == kDWTimeCode2997;
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
	}
}

+(void)ComputeHh:(unsigned int *)hh Mm:(unsigned int *)mm Ss:(unsigned int *)ss Ff:(unsigned int *)ff fromFrame:(DWFrame)frame andType:(DWTimeCodeType)type {
	DWFrame fps = [DWTimeCode getFps:type];
	BOOL drop = [DWTimeCode isDrop:type];
	DWFrame n = ABS(frame);
	
	// computing hour
	DWFrame framePerHour = 3600 * fps;
	if(drop)
		framePerHour -= 108;
	*hh = n / framePerHour;
	n = n % framePerHour;
	
	// computing tenth of minutes
	DWFrame framePerTenMinutes = 600 * fps;
	if(drop)
		framePerTenMinutes -= 18;
	*mm = 10 * (n / framePerTenMinutes);
	n = n % framePerTenMinutes;
	
	// computing minutes
	DWFrame framePerMinute = 60 * fps;
	if (n >= framePerMinute) {
		*mm += 1;
		n -= framePerMinute;
		
		if (drop)
			framePerMinute -= 2;
		
		*mm += n / framePerMinute;
		n = n % framePerMinute;
	}
	
	// computing seconds
	DWFrame framePerSecond = fps;
	
	if (drop && (*mm % 10 > 0)) {
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

+(DWFrame)frameFromHh:(unsigned int)hh Mm:(unsigned int)mm Ss:(unsigned int)ss Ff:(unsigned int)ff andType:(DWTimeCodeType)type {
	DWFrame fps = [DWTimeCode getFps:type];
	
	if (mm>=60) {
		DWLog(@"Bad minute value: %u", mm);
		mm = 0;
	}
	if (ss>=60) {
		DWLog(@"Bad second value: %u", ss);
		ss = 0;
	}
	if (ff>=fps) {
		DWLog(@"Bad frame value: %u", ff);
		ff = 0;
	}
	DWFrame dropframe = 0;
	if ([DWTimeCode isDrop:type]) {
		// counting drop per hour
		dropframe += hh * 108;
		// counting drop per tenth of minute
		dropframe += (mm/10) * 18;
		// counting drop per minute
		dropframe += (mm%10) * 2;
	}
	return (((hh * 60) + mm) * 60 + ss) * fps + ff - dropframe;
}
@end
