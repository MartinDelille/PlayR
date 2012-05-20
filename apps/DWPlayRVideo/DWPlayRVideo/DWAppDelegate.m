//
//  DWAppDelegate.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWSony/DWSonySlaveController.h"

@implementation DWAppDelegate {
	DWSonySlaveController * sony;
}

@synthesize window = _window;
@synthesize videoView = _videoView;
@synthesize controlPanel;
@synthesize currentTCText;
@synthesize clock;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	sony = [[DWSonySlaveController alloc] init];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidResizeNotification object:self.window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidBecomeMainNotification object:self.window];
	
	[self.window addChildWindow:controlPanel ordered:NSWindowAbove];

	self.window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
	
	// TODO: handle sony sync
	clock.currentReference = nil;
	sony.clock = clock;

	[sony start];
	
	self.videoView.mainController = self;
	self.videoView.player = clock.player;
	
	[clock addObserver:self forKeyPath:@"state" options:0 context:nil];
	[clock addObserver:self forKeyPath:@"time" options:0 context:nil];


	[self showControlPanel];
	[self.window setAcceptsMouseMovedEvents:YES];
}

-(void)applicationWillTerminate:(NSNotification *)notification {
	[sony stop];
}

- (void)openDocument:(id)sender {
	NSLog(@"openDocument");
	[self showControlPanel];
	NSOpenPanel * panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories:NO];
    [panel setAllowedFileTypes:[NSArray arrayWithObject:@"mov"]];
	
    [panel  beginWithCompletionHandler:^(NSInteger result)
	 {
		 if (result==NSFileHandlingPanelOKButton)
		 {
			 DWLog(@"Loading %@", panel.URL);
			 if (![clock loadWithUrl:panel.URL]) {
				 // TODO : add error message
				 DWLog(@"error");
			 }
		 }
		[self showControlPanelAndHide];
	 }];	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"state"]) {
		if (clock.state == kDWVideoClockStateReady) {
			// TODO handle state notification
			DWLog(@"clock state changes to %d", clock.state);
		}
	}
	else if ([keyPath isEqualToString:@"time"]) {
		self.currentTCText.stringValue = clock.tcString;
	}
}

- (IBAction)rewind:(id)sender {
	// TODO : parameter this
	clock.rate = -10;
}

- (IBAction)reversePlay:(id)sender {
	clock.rate = -1;
}

- (IBAction)pause:(id)sender {
	clock.rate = 0;
}

- (IBAction)play:(id)sender {
	clock.rate = 1;
}

- (IBAction)playPause {
	if (clock.rate == 0) {
		clock.rate = 1;
	}
	else {
		clock.rate = 0;
	}
}

- (IBAction)fastForward:(id)sender {
	// TODO : parameter this
	clock.rate = 10;
}

-(void)updateControlPanelPosition:(NSNotification*)note {
	DWLog(@"%@", note.name);
	NSRect subFrameRect = self.controlPanel.frame;
	NSRect frameRect = self.window.frame;
	subFrameRect.origin.x = frameRect.origin.x + (frameRect.size.width - subFrameRect.size.width)/2;
	subFrameRect.origin.y = frameRect.origin.y + (frameRect.size.height)/8;
	
	[self.controlPanel setFrame:subFrameRect display:YES animate:YES];
	[self.controlPanel orderFront:self];
	
}

-(void)showControlPanel {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlPanel) object:nil];
	if (self.controlPanel.alphaValue == 0) {
		[[self.controlPanel animator] setAlphaValue:1];
	}
}

-(void)showControlPanelAndHide {
	[self showControlPanel];
	[self performSelector:@selector(hideControlPanel) withObject:nil afterDelay:3];
}

-(void)hideControlPanel {
	[[self.controlPanel	animator] setAlphaValue:0];
	if (self.window.styleMask & NSFullScreenWindowMask) {
		[NSCursor setHiddenUntilMouseMoves:YES];
	}
}

@end
