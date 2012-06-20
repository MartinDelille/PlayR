//
//  DWTestPaintView.m
//  BasicPaintTest01
//
//  Created by Martin Delille on 19/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTestPaintView.h"
#import <OpenGL/gl.h>

@implementation DWTestPaintView {
	float x;
}

-(void)doPaint {
	// Clear the screen buffer
	glClear( GL_COLOR_BUFFER_BIT );
	glLoadIdentity();   // Reset the current modelview matrix
	glTranslatef( x, 0.0, -1 );      // Move into screen 5 units

	[self drawQuad:NSMakeRect(0, 0, 50, 50)];

	x -= 4;
	if (x <  -200) {
		x = self.bounds.size.width;
	}
	else if (x>self.bounds.size.width) {
		x = 0;
	}
}

@end
