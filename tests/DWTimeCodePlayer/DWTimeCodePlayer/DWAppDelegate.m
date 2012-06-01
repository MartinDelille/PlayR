//
//  DWAppDelegate.m
//  DWTimeCodePlayer
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWClocking/DWInternalReference.h"

@implementation DWAppDelegate {
	DWInternalReference * internalRef;
}

@synthesize clock = _clock;

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// TODO: handle tc type
	
	self.clock.tcString = @"01:00:00:00";

	internalRef = [[DWInternalReference alloc] initWithClock:self.clock];
	self.clock.currentReference = internalRef;
	[internalRef start];
	NSLog(@"%@", internalRef);
	NSLog(@"%@", self.clock.currentReference);
}

-(void)applicationWillTerminate:(NSNotification *)notification {
	[internalRef stop];
}

- (IBAction)stop:(id)sender {
	self.clock.rate = 0;
}

- (IBAction)play:(id)sender {
	self.clock.rate = 1;
}

- (IBAction)nextFrame:(id)sender {
	self.clock.rate = 0;
	self.clock.frame++;
}

- (IBAction)previousFrame:(id)sender {
	self.clock.rate = 0;
	self.clock.frame--;
}

- (IBAction)rewind:(id)sender {
	self.clock.rate = -10;
}

- (IBAction)fastForward:(id)sender {
	self.clock.rate = 10;
}

@end
