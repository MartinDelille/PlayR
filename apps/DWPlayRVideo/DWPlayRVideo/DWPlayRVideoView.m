//
//  DWPlayRVideoView.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 17/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWPlayRVideoView.h"
#import "DWAppDelegate.h"

@implementation DWPlayRVideoView

@synthesize mainController;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

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
