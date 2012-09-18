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

-(void)enterFullscreen:(NSNotification*)note {
	DWLog(@"");
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"DWPlayRFullscreen"];
}

-(void)exitFullscreen:(NSNotification*)note {
	DWLog(@"");
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"DWPlayRFullscreen"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Load default defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"]]];
	
	DWLogLevel logLevel = (DWLogLevel)[[NSUserDefaults standardUserDefaults] integerForKey:@"DWLogLevel"];
	[DWLogger configureLogLevel:logLevel];
	DWLog(@"Configuring log level to %X", logLevel);
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidResizeNotification object:self.window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidBecomeMainNotification object:self.window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFullscreen:) name:NSWindowDidEnterFullScreenNotification object:self.window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullscreen:) name:NSWindowDidExitFullScreenNotification object:self.window];
	
	
	controlPanelController = [[DWControlPanelWindowController alloc] init];
	[self.window addChildWindow:controlPanelController.window ordered:NSWindowAbove];
	controlPanelController.clockController.content = self.clock;
	[self updateControlPanelPosition:nil];
	
	self.window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DWPlayRFullscreen"]) {
//		[self.window.contentView enterFullScreenMode:[NSScreen mainScreen] withOptions:nil];
//		self.window.styleMask |= NSFullScreenWindowMask;
	}
	
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
	
	self.window.mainController = self;
	self.videoView.player = clock.player;
	
	[clock addObserver:self forKeyPath:@"state" options:0 context:nil];
//	[clock addObserver:self forKeyPath:@"time" options:0 context:nil];

	[self showControlPanelAndHide];
	self.window.acceptsMouseMovedEvents = YES;
	
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

-(BOOL)processVideoUrl:(NSURL*)url {
	DWLog(@"%@", url);
	if ([clock loadWithUrl:url]) {
		[[NSUserDefaults standardUserDefaults] setURL:url forKey:@"DWPlayRLastVideoFile"];
		return YES;
	}
	else {
		return NO;
	}
}

- (void)openDocument:(id)sender {
	NSLog(@"openDocument");
	[self showControlPanel];
	NSOpenPanel * panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories:NO];
    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"mov", @"mp4", @"avi", @"mpg", nil]];
	
    [panel  beginWithCompletionHandler:^(NSInteger result)
	 {
		 if (result==NSFileHandlingPanelOKButton) {
			 [self processVideoUrl:panel.URL];
		 }
		[self showControlPanelAndHide];
	 }];	
}

-(BOOL)application:(NSApplication *)sender openFile:(NSString *)filename {
	NSURL * url = [NSURL fileURLWithPath:filename];
	return [self processVideoUrl:url];
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

-(void)updateControlPanelPosition:(NSNotification*)note {
	DWLog(@"%@", note.name);
	NSRect subFrameRect = controlPanelController.window.frame;
	NSRect frameRect = self.window.frame;
	subFrameRect.origin.x = frameRect.origin.x + (frameRect.size.width - subFrameRect.size.width)/2;
	subFrameRect.origin.y = frameRect.origin.y + (frameRect.size.height)/32;
	
	// animate only if this message is triggered by a notification
	[controlPanelController.window setFrame:subFrameRect display:YES animate:(note != nil)];
//	[self.controlPanel orderFront:self];
	[self showControlPanelAndHide];
}

-(void)showControlPanel {
	[NSCursor unhide];
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
		[NSCursor hide];
	}
}

- (IBAction)changeTimestamp:(id)sender {
	if (timestampController == nil) {
		timestampController = [[DWTimestampWindowController alloc] init];
	}
	
	[self showControlPanel];
	
	timestampController.tcString = clock.tcString;
	NSInteger code = [NSApp runModalForWindow:timestampController.window];
	
	if (code == 1) {
		DWLog(@"Changing timestamp with tc: %@", timestampController.tcString);
		[clock updateTimestampWithCurrentTimecodeString:timestampController.tcString];
		[DWTimecodeDatabase storeTimecode:clock.timeStampString forURL:clock.url];
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
