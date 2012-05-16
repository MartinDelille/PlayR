//
//  DWAppDelegate.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWVideo/DWVideoClock.h"
#import "DWSony/DWSonySlaveController.h"

@implementation DWAppDelegate {
	DWVideoClock * clock;
	DWSonySlaveController * sony;
}

@synthesize window = _window;
@synthesize videoView = _videoView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	sony = [[DWSonySlaveController alloc] init];
	[sony start];
}

-(void)applicationWillTerminate:(NSNotification *)notification {
	[sony stop];
}

- (void)openDocument:(id)sender {
	NSLog(@"openDocument");
	NSOpenPanel * panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories:NO];
    [panel setAllowedFileTypes:[NSArray arrayWithObject:@"mov"]];
	
    [panel  beginWithCompletionHandler:^(NSInteger result)
	 {
		 if (result==NSFileHandlingPanelOKButton)
		 {
			 DWVideoClock * newClock = [[DWVideoClock alloc] initWithUrl:panel.URL];
			 
			 if (newClock != nil) {
				 clock = newClock;
				 [clock addObserver:self forKeyPath:@"state" options:0 context:nil];
			 }
		 }
	 }];	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"state"]) {
		if (clock.state == kDWVideoClockStateReady) {
			self.videoView.player = clock.player;
			// TODO: handle sony sync
			clock.currentReference = nil;
			sony.clock = clock;
		}
	}
}

@end
