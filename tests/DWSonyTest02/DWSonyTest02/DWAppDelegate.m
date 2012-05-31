//
//  DWAppDelegate.m
//  DWSonyTest02
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWSony/DWSonySlaveController.h"

@implementation DWAppDelegate {
	DWSonySlaveController * sony;
}

@synthesize window = _window;
@synthesize currentStatusText = _currentStatusText;
@synthesize txtSyncState = _txtSyncState;
@synthesize clock = _clock;

-(BOOL)useInternaleSync {
	return self.clock.currentReference != sony;
}

-(void)setUseInternaleSync:(BOOL)useInternaleSync {
	if (useInternaleSync) {
		self.clock.currentReference = self;
	}
	else {
		self.clock.currentReference = sony;
	}
}

-(void)onTick {
	[self.clock tickFrame:self];
	
	if (sony != nil) {
		if (self.useInternaleSync) {
			self.txtSyncState.stringValue = @"N/A";
			self.txtSyncState.backgroundColor = nil;
		}
		else {
			NSTimeInterval interval = [self.clock.lastTickDate timeIntervalSinceNow];
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
	else {
		self.txtSyncState.stringValue = @"No USB device";
		self.txtSyncState.backgroundColor = [NSColor redColor];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic];

	// TODO : handle tc type
	
	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(onTick) userInfo:nil repeats:YES];	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
	
	sony = [[DWSonySlaveController alloc] init];
	sony.clock = self.clock;
	self.clock.currentReference = sony;
	
	[sony start];
}

-(NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
	[sony stop];
	
	return NSTerminateNow;
}

@end
