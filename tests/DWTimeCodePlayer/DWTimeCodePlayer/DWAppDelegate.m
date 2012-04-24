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
	clock = [[DWClock alloc] initWithType:kDWTimeCode25];
	
	[clock addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew context:nil];
	clock.tcString = @"01:00:00:00";
	
	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:clock selector:@selector(tickFrame) userInfo:nil repeats:YES];
	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)stop:(id)sender {
	clock.rate = 0;
}

- (IBAction)play:(id)sender {
	clock.rate = 1;
}

- (IBAction)nextFrame:(id)sender {
	clock.frame++;
}

- (IBAction)previousFrame:(id)sender {
	clock.frame--;
}

- (IBAction)rewind:(id)sender {
	clock.rate = -10;
}

- (IBAction)fastForward:(id)sender {
	clock.rate = 10;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	self.tcText.stringValue = clock.tcString;
}			


@end
