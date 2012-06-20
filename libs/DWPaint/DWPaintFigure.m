//
//  DWPaintFigure.m
//  DWPaint
//
//  Created by Martin Delille on 20/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWPaintFigure.h"
#import <OpenGL/gl.h>

@implementation DWPaintFigure

+(void)drawQuad:(NSRect)rect {
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

@end
