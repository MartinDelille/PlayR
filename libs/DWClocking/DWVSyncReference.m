//
//  DWVSyncReference.m
//  DWClocking
//
//  Created by Martin Delille on 01/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVSyncReference.h"
#import <CoreVideo/CoreVideo.h>

@implementation DWVSyncReference {
	CVDisplayLinkRef displayLink;
}

@synthesize clock;

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime,
									  CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
{
	@autoreleasepool {
		DWVSyncReference * ref = (__bridge DWVSyncReference*)displayLinkContext;;
		DWTime interval = outputTime->videoRefreshPeriod * DWTIMESCALE / outputTime->videoTimeScale;
		[ref.clock tick:ref withInterval:interval];
	}
    return kCVReturnSuccess;
}

-(void)start {
	// Create a display link capable of being used with all active displays
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
	
    // Set the renderer output callback function
    CVDisplayLinkSetOutputCallback(displayLink, &MyDisplayLinkCallback, (__bridge void*)self);
	
	//	CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
	
    // Activate the display link
    CVDisplayLinkStart(displayLink);

}

-(void)stop {
	// TODO
}
@end
