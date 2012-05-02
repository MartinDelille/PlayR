//
//  DWAppDelegate.m
//  DWSonyMasterTest01
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWClocking/DWClock.h"
#import "DWSony/DWSonyMasterController.h"

@implementation DWAppDelegate {
	DWClock * clock;
	DWSonyMasterController * sony;
	
}

@synthesize window = _window;
@synthesize currentTCText = _currentTCText;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	clock = [[DWClock alloc] initWithType:kDWTimeCode25];
	
	sony = [[DWSonyMasterController alloc] initWithClock:clock];
	
	[clock addObserver:self forKeyPath:@"time" options:NSKeyValueChangeNewKey context:nil];
	
	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:sony selector:@selector(checkTime) userInfo:nil repeats:YES];
	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)play:(id)sender {
	[sony play];
}

- (IBAction)stop:(id)sender {
	[sony stop];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
self.currentTCText.stringValue = clock.tcString;
}

@end
