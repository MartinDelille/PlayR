//
//  DWAppDelegate.m
//  DWSonyTest02
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWClocking/DWClock.h"
#import "DWSony/DWSonySlaveController.h"

@implementation DWAppDelegate {
	DWClock * clock;
	DWSonySlaveController * sony;
}

@synthesize window = _window;
@synthesize currentRateText = _currentRateText;
@synthesize currentTCText = _currentTCText;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// TODO : handle tc type
	clock = [[DWClock alloc] initWithType:kDWTimeCode24];
	
	[clock addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew context:nil];
	[clock addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
	clock.tcString = @"21:03:10:02";
	clock.rate = 0;

	// TODO switch between internal clock and video reference
//	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:clock selector:@selector(tickFrame) userInfo:nil repeats:YES];	
//	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
	
	sony = [[DWSonySlaveController alloc] initWithClock:clock];
	
	[sony start];
}

-(NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
	[sony stop];
	
	return NSTerminateNow;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"time"]) {
		self.currentTCText.stringValue = clock.tcString;
	} 
	else if ([keyPath isEqualToString:@"rate"]) {
		self.currentRateText.stringValue = [NSString stringWithFormat:@"%.2f", clock.rate];
	}
}

@end
