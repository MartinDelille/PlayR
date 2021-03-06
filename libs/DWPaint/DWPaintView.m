//
//  DWPaintView.m
//  BasicPaintTest01
//
//  Created by Martin Delille on 19/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWPaintView.h"
#import <QuartzCore/QuartzCore.h>


@implementation DWPaintView {
	CVDisplayLinkRef displayLink;
}

-(void)dealloc {
	CVDisplayLinkStop(displayLink);
}

-(void)render {
	CGLContextObj ctx = [self.openGLContext CGLContextObj];
	CGLLockContext(ctx);
	
	[self.openGLContext makeCurrentContext];
	
	[self doPaint];
	
	glFlush();
	
	CGLUnlockContext(ctx);
}


- (void)drawRect:(NSRect)dirtyRect
{
    [self render];
}

// This is the renderer output callback function
static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
{
	@autoreleasepool {
		DWPaintView * view = (__bridge DWPaintView*)displayLinkContext;
		[view render];
	}
	
	return kCVReturnSuccess;
}

-(void)prepareOpenGL {	
    // Set the display link for the current renderer
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
	
	CGLError err =  CGLEnable( cglContext, kCGLCEMPEngine);
	
	if (err != kCGLNoError )
	{
		NSLog(@"Multithreaded execution may not be available");
		// Insert your code to take appropriate action
	}
	
	glEnable( GL_TEXTURE_2D );                // Enable texture mapping
	glShadeModel( GL_SMOOTH );                // Enable smooth shading
	glClearColor( 0.0f, 0.0f, 0.0f, 0.5f );   // Black background
	// Really nice perspective calculations
	glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

	// Create a display link capable of being used with all active displays
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);	
	
    // Set the renderer output callback function
    CVDisplayLinkSetOutputCallback(displayLink, &MyDisplayLinkCallback, (__bridge void*)self);

	CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
	
	CVDisplayLinkStart(displayLink);

	NSLog(@"%s over", __PRETTY_FUNCTION__);
}

-(void)reshape {
	NSLog(@"%s", __PRETTY_FUNCTION__);
	CGLContextObj ctx = [self.openGLContext CGLContextObj];
	CGLLockContext(ctx);
	//	NSLog(@"%s : %@", __PRETTY_FUNCTION__, NSStringFromRect(self.bounds));
	NSSize sceneSize;
	
	[ [ self openGLContext ] update ];
	sceneSize = self.bounds.size;
	// Reset current viewport
	glViewport( 0, 0, sceneSize.width, sceneSize.height );
	glMatrixMode( GL_PROJECTION );   // Select the projection matrix
	glLoadIdentity();                // and reset it
	glOrtho(0, sceneSize.width, 0, sceneSize.height, 0, 1000);
	
	glMatrixMode( GL_MODELVIEW );    // Select the modelview matrix
	glLoadIdentity();                // and reset it
	
	CGLUnlockContext(ctx);
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)doPaint {
	// just clear the view: override to perform custom painting
	glClear( GL_COLOR_BUFFER_BIT );	
}

@end
