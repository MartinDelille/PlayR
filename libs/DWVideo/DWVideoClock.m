//
//  DWVideoClock.m
//  DWVideo
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideoClock.h"
#import "DWTools/DWLogger.h"
#import "DWClocking/DWTimeCode.h"
#include <QuickTime/Movies.h>
#include <QuickTime/QuickTime.h>

@implementation DWVideoClock 

@synthesize videoStartTime = _videoStartTime;

-(id)initWithMovie:(QTMovie *)aMovie {
	DWTimeCodeType type;
	double frameRate = 0;
	for (QTTrack * track in [aMovie tracks]) {
		QTMedia * media = [track media];
		if([media hasCharacteristic:QTMediaCharacteristicHasVideoFrameRate]) {
			QTTime mediaDuration = [(NSValue*)[media attributeForKey:QTMediaDurationAttribute] QTTimeValue];
            long long mediaDurationScaleValue = mediaDuration.timeScale;
            long mediaDurationTimeValue = mediaDuration.timeValue;
            long mediaSampleCount = [(NSNumber*)[media attributeForKey:QTMediaSampleCountAttribute] longValue];
            frameRate = (double)mediaSampleCount * ((double)mediaDurationScaleValue / (double)mediaDurationTimeValue);
            break;
		}
		
	}
	DWLog(@"framerate = %.2f", frameRate);

	if (frameRate < 24) {
		type = kDWTimeCode2398;
	}
	else if (frameRate < 25) {
		type = kDWTimeCode24;
	}
	else if (frameRate == 25) {
		type = kDWTimeCode25;
	}
	else {
		type = kDWTimeCode2997;
	}

	self = [super initWithType:type];

	movie = aMovie;
	
	DWLog(@"timescale = %@", [movie attributeForKey:QTMovieTimeScaleAttribute]);
	[movie setAttribute:[NSNumber numberWithLong:DWTIMESCALE] forKey:QTMovieTimeScaleAttribute];
	DWLog(@"timescale = %@", [movie attributeForKey:QTMovieTimeScaleAttribute]);

	// Checking timestamp
	_videoStartTime = 906036 * self.timePerFrame;
/*	NSArray * trackArray = [movie tracksOfMediaType:QTMediaTypeTimeCode];
	if (trackArray.count > 0) {
		QTTrack * tcTrack = [trackArray objectAtIndex:0];
		if (tcTrack != nil) {
			QTMedia * media = [tcTrack media];
			if (media != nil) {
			//	MediaHandler handler = GetMediaHandler([media quickTimeMedia]);
			}
		}
	}*/
	

	
	return self;
}

-(DWTime)timeFromQTTime:(QTTime)qttime {
	
	return qttime.timeValue + self.videoStartTime;
}

-(QTTime)qttimeFromTime:(DWTime)time {
	return QTMakeTime(time - self.videoStartTime, DWTIMESCALE);
}

-(void)tickFrame {
	self.time = [self timeFromQTTime:[movie currentTime]];
	self.rate = movie.rate;
}

@end
