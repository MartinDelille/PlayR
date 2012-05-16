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
#import "DWTools/DWLogger.h"

@implementation DWAppDelegate {
	DWClock * clock;
	DWSonyMasterController * sony;
	
}

@synthesize window = _window;
@synthesize currentTCText = _currentTCText;
@synthesize txtStatus0 = _txtStatus0;

-(void)check {
	[sony timeSense];
	[sony statusSense];
	self.currentTCText.stringValue = clock.tcString;
	self.txtStatus0.stringValue = [NSString stringWithFormat:@"%.2x %.2x %.2x %.2x", [sony statusAtIndex:0], [sony statusAtIndex:1], [sony statusAtIndex:2], [sony statusAtIndex:3]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic];

	clock = [[DWClock alloc] init];
	
	sony = [[DWSonyMasterController alloc] init];
	sony.clock = clock;
	
//	[clock addObserver:self forKeyPath:@"time" options:NSKeyValueChangeSetting context:nil];
	
	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(check) userInfo:nil repeats:YES];
	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)play:(id)sender {
	[sony play];
}

- (IBAction)stop:(id)sender {
	[sony stop];
}

- (IBAction)fastForward:(id)sender {
	[sony fastForward];
}

- (IBAction)jogRev1x:(id)sender {
	[sony jog:-1];
}

- (IBAction)rewind:(id)sender {
	[sony rewind];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//	self.currentTCText.stringValue = clock.tcString;
//}



@end
