//
//  DWPlayRWindow.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 20/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWPlayRWindow.h"
#import "DWAppDelegate.h"

@implementation DWPlayRWindow

@synthesize mainController;

-(BOOL)acceptsFirstResponder {
	return YES;
}

-(void)keyDown:(NSEvent *)theEvent {
	DWLog(@"keyCode: %X", theEvent.keyCode);
	switch (theEvent.keyCode) {
		case 0x31:
			[mainController playPause];
			break;
		default:
			[super keyDown:theEvent];
			break;
	}
}

-(void)mouseMoved:(NSEvent *)theEvent {
	[mainController showControlPanelAndHide];
}


@end
