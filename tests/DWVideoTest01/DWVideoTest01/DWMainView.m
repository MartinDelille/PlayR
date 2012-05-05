//
//  DWMainView.m
//  DWVideoTest01
//
//  Created by Martin Delille on 05/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWMainView.h"
#import "DWDocument.h"

@implementation DWMainView

@synthesize doc;

-(BOOL)acceptsFirstResponder {
	return YES;
}

-(void)keyDown:(NSEvent *)theEvent {
	DWLog(@"keyCode: %X", theEvent.keyCode);
	switch (theEvent.keyCode) {
		case 0x31:
			[doc playPause];
			break;
		default:
			[super keyDown:theEvent];
			break;
	}
}

-(void)scrollWheel:(NSEvent *)theEvent {
	DWLog(@"f: %f", theEvent.scrollingDeltaX);
	[doc shuttle:theEvent.scrollingDeltaX];
}

@end
