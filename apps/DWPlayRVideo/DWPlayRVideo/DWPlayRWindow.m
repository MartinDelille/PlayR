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

-(void)mouseMoved:(NSEvent *)theEvent {
	[mainController showControlPanelAndHide];
}

@end
