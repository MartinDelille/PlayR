//
//  DWTestPaintView.m
//  BasicPaintTest01
//
//  Created by Martin Delille on 19/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTestPaintView.h"
#import <OpenGL/gl.h>

@implementation DWTestPaintView

-(void)doPaint {
	// Clear the screen buffer
	glClear( GL_COLOR_BUFFER_BIT );
	glLoadIdentity();   // Reset the current modelview matrix
	
	[self drawQuad:NSMakeRect(0, 0, 50, 50)];

}

@end
