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
@synthesize currentStatusText = _currentStatusText;
@synthesize txtSyncState = _txtSyncState;


-(BOOL)useInternaleSync {
	return !sony.useSonySync;
}

-(void)setUseInternaleSync:(BOOL)useInternaleSync {
	sony.useSonySync = !useInternaleSync;
}

-(void)onTick {
	if (self.useInternaleSync) {
		[clock tickFrame];
		self.txtSyncState.stringValue = @"N/A";
		self.txtSyncState.backgroundColor = nil;
	}
	else {
		NSTimeInterval interval = [clock.lastTickDate timeIntervalSinceNow];
		// TODO: make a parameter from the max duration
		if (interval < -1) {
			self.txtSyncState.stringValue = @"Bad";
			self.txtSyncState.backgroundColor = [NSColor redColor];
		}
		else if (interval < -0.06) {
			self.txtSyncState.stringValue = @"Medium";
			self.txtSyncState.backgroundColor = [NSColor orangeColor];
		}
		else {
			self.txtSyncState.stringValue = @"Good";
			self.txtSyncState.backgroundColor = [NSColor greenColor];
		}
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic];

	// TODO : handle tc type
	clock = [[DWClock alloc] initWithType:kDWTimeCode24];
	
	[clock addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew context:nil];
	[clock addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
	clock.tcString = @"21:03:10:02";
	clock.rate = 0;

	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(onTick) userInfo:nil repeats:YES];	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
	
	sony = [[DWSonySlaveController alloc] initWithClock:clock];
	self.useInternaleSync = NO;
	
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

	self.currentStatusText.stringValue = [NSString stringWithFormat:@"%.2x %.2x %.2x %.2x", [sony statusAtIndex:0], [sony statusAtIndex:1], [sony statusAtIndex:2], [sony statusAtIndex:3]];
}

@end
