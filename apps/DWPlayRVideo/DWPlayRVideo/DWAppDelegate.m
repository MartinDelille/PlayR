//
//  DWAppDelegate.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWSony/DWSonySlaveController.h"
#import "DWTimestampWindowController.h"
#import "DWTimecodeDatabase.h"
#import "DWControlPanelWindowController.h"

@implementation DWAppDelegate {
	DWSonySlaveController * sony;
	DWTimestampWindowController * timestampController;
	DWControlPanelWindowController * controlPanelController;
}

@synthesize window = _window;
@synthesize videoView = _videoView;
@synthesize clock;
@synthesize preferencesPanel;

-(void)tickFrame {
	NSTimeInterval interval = -[clock.lastTickDate timeIntervalSinceNow];
	
	NSString * referenceOrigin = [[NSUserDefaults standardUserDefaults] stringForKey:@"DWPlayRReferenceOrigin"];
	
	if ([referenceOrigin isEqualToString:@"Video"]) {
		clock.currentReference = sony;
		if (interval < 0.05) {
			controlPanelController.refStatusString = @"Good";
		}
		else if (interval < 1) {
			controlPanelController.refStatusString = @"Bad";
		}
		else {
			controlPanelController.refStatusString = @"No signal";
		}
	}
	else {
		clock.currentReference = self;
		[clock tickFrame:self];
		controlPanelController.refStatusString = @"Internal";
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Load default defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"]]];
	
	DWLogLevel logLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"DWLogLevel"];
	[DWLogger configureLogLevel:logLevel];
	DWLog(@"Configuring log level to %X", logLevel);
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidResizeNotification object:self.window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidBecomeMainNotification object:self.window];
	
	controlPanelController = [[DWControlPanelWindowController alloc] init];
	[self.window addChildWindow:controlPanelController.window ordered:NSWindowAbove];
	controlPanelController.clockController.content = self.clock;
	[self updateControlPanelPosition:nil];
	
	self.window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
	
	// TODO : add full screen state in the settings

	controlPanelController.syncStatusString = @"Connecting...";
	sony = [[DWSonySlaveController alloc] init];
	if (sony == nil) {
		controlPanelController.syncStatusString = @"Not connected";
	}
	else {
		controlPanelController.syncStatusString = @"Connected";

		sony.clock = clock;
		
		[sony start];
	}	
	
	self.videoView.mainController = self;
	self.videoView.player = clock.player;
	
	[clock addObserver:self forKeyPath:@"state" options:0 context:nil];
//	[clock addObserver:self forKeyPath:@"time" options:0 context:nil];


	[self showControlPanel];
	[self.window setAcceptsMouseMovedEvents:YES];
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DWPlayRReloadLastFile"]) {
		NSURL * lastVideoFile = [[NSUserDefaults standardUserDefaults] URLForKey:@"DWPlayRLastVideoFile"];
		if (lastVideoFile != nil) {
			DWLog(@"Trying to load %@", lastVideoFile);
			[clock loadWithUrl:lastVideoFile];
		}		
	}
	else {
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@"html"]; 
		[self.videoView setMainFrameURL:filePath];
	}
	
	controlPanelController.refStatusString = @"Bad";
	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(tickFrame) userInfo:nil repeats:YES];	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
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
			 if ([clock loadWithUrl:panel.URL]) {
				 [[NSUserDefaults standardUserDefaults] setURL:panel.URL forKey:@"DWPlayRLastVideoFile"];
			 }
			 else {
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
			if (clock.originalTimeStampFrame == 0) {
				NSString * tc = [DWTimecodeDatabase timecodeForURL:clock.url];
				if (tc == nil) {
					tc = @"01:00:00:00";
				}
				[clock updateTimestampWithCurrentTimecodeString:tc];
				[self performSelector:@selector(changeTimestamp:) withObject:self afterDelay:0.5];
			}
		}
	}
}

- (IBAction)playPause {
	if (clock.rate == 0) {
		clock.rate = 1;
	}
	else {
		clock.rate = 0;
	}
}

-(void)updateControlPanelPosition:(NSNotification*)note {
	DWLog(@"%@", note.name);
	NSRect subFrameRect = controlPanelController.window.frame;
	NSRect frameRect = self.window.frame;
	subFrameRect.origin.x = frameRect.origin.x + (frameRect.size.width - subFrameRect.size.width)/2;
	subFrameRect.origin.y = frameRect.origin.y + (frameRect.size.height)/32;
	
	// animate only if this message is triggered by a notification
	[controlPanelController.window setFrame:subFrameRect display:YES animate:(note != nil)];
//	[self.controlPanel orderFront:self];
}

-(void)showControlPanel {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlPanel) object:nil];
	if (controlPanelController.window.alphaValue == 0) {
		[[controlPanelController.window animator] setAlphaValue:1];
	}
}

-(void)showControlPanelAndHide {
	[self showControlPanel];
	[self performSelector:@selector(hideControlPanel) withObject:nil afterDelay:3];
}

-(void)hideControlPanel {
	[[controlPanelController.window	animator] setAlphaValue:0];
	if (self.window.styleMask & NSFullScreenWindowMask) {
		[NSCursor setHiddenUntilMouseMoves:YES];
	}
}

- (IBAction)changeTimestamp:(id)sender {
	if (timestampController == nil) {
		timestampController = [[DWTimestampWindowController alloc] init];
	}
	
	[self showControlPanel];
	
	timestampController.tcString = clock.tcString;
	int code = [NSApp runModalForWindow:timestampController.window];
	
	if (code == 1) {
		DWLog(@"Changing timestamp with tc: %@", timestampController.tcString);
		[clock updateTimestampWithCurrentTimecodeString:timestampController.tcString];
		[DWTimecodeDatabase storeTimecode:timestampController.tcString forURL:clock.url];
	}
	else {
		DWLog(@"cancel with code : %d", code);
	}
	
	[self showControlPanelAndHide];
}

- (IBAction)clearTimestampDatabase:(id)sender {
	[DWTimecodeDatabase clear];
}

- (IBAction)showPreferences:(id)sender {
	[self showControlPanelAndHide];
	[preferencesPanel makeKeyAndOrderFront:self];
}

- (IBAction)changeDelayUnit:(id)sender {
	double delay = [[NSUserDefaults standardUserDefaults] doubleForKey:@"DWVideoDelayCompensation"];
	[[NSUserDefaults standardUserDefaults] setDouble:delay forKey:@"DWVideoDelayCompensation"];
}

@end
