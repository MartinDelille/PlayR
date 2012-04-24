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
	
	[clock addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew context:nil];
	clock.tcString = @"01:00:00:00";
}

- (IBAction)nextFrame:(id)sender {
	clock.frame++;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	self.tcText.stringValue = clock.tcString;
}


@end
