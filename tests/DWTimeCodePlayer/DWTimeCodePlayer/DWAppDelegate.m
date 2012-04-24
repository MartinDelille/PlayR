//
//  DWAppDelegate.m
//  DWTimeCodePlayer
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"

@implementation DWAppDelegate

@synthesize clock;
@synthesize window = _window;
@synthesize tcText = _tcText;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	clock = [[DWClock alloc] initWithType:kDWTimeCode24];
	clock.tcString = @"01:00:00:00";
	self.tcText.stringValue = clock.tcString;
}

- (IBAction)nextFrame:(id)sender {
	clock.frame++;
	self.tcText.stringValue = clock.tcString;
}
@end
