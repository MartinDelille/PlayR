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
	// Create a display link capable of being used with all active displays
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
	
	
    // Set the renderer output callback function
    CVDisplayLinkSetOutputCallback(displayLink, &MyDisplayLinkCallback, (__bridge void*)self);
	
    // Set the display link for the current renderer
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
	
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


-(void)drawQuad:(NSRect)rect {
	glBegin( GL_QUADS );
	
	glTexCoord2f( 0.0f, 0.0f );
	glVertex2f( rect.origin.x, rect.origin.y);   // Bottom left
	glTexCoord2f( 1.0f, 0.0f );
	glVertex2f(  rect.origin.x + rect.size.width, rect.origin.y);   // Bottom right
	glTexCoord2f( 1.0f, 1.0f );
	glVertex2f(  rect.origin.x + rect.size.width, rect.origin.y + rect.size.height );   // Top right
	glTexCoord2f( 0.0f, 1.0f );
	glVertex2f( rect.origin.x, rect.origin.y + rect.size.height );   // Top left
	
	glEnd();
	
}

-(void)render {
	CGLContextObj ctx = [self.openGLContext CGLContextObj];
	CGLLockContext(ctx);
	
	[self.openGLContext makeCurrentContext];
	// Clear the screen buffer
	glClear( GL_COLOR_BUFFER_BIT );
	glLoadIdentity();   // Reset the current modelview matrix
	
	[self drawQuad:NSMakeRect(0, 0, 50, 50)];
	
	glFlush();
	
	CGLUnlockContext(ctx);
}


@end
