//
//  DWDocument.m
//  DWVideoTest01
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWDocument.h"
#import "DWTools/DWLogger.h"
#import "DWVideoView.h"
#import "DWMainView.h"

@implementation DWDocument

@synthesize videoView;
@synthesize mainView;
@synthesize controlPanel;
@synthesize mainWindow;
@synthesize txtCurrentTC;
@synthesize clock;

- (id)init
{
    self = [super init];
    if (self) {
		
    }
    return self;
}

-(void)dealloc {
	if (self.clock != nil) {
		clock.rate = 0;
		[self.clock removeObserver:self forKeyPath:@"currentFrame"];
		[self.clock removeObserver:self forKeyPath:@"state"];
	}
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"DWDocument";
}

-(void)updateControlPanelPosition:(NSNotification*)note {
	DWLog(@"%@", note.name);
	NSRect subFrameRect = self.controlPanel.frame;
	NSRect frameRect = self.mainWindow.frame;
	subFrameRect.origin.x = frameRect.origin.x + (frameRect.size.width - subFrameRect.size.width)/2;
	subFrameRect.origin.y = frameRect.origin.y + (frameRect.size.height)/8;
	
	//	[controlPanel setFrame:subFrameRect display:flag];
	[self.controlPanel setFrame:subFrameRect display:YES animate:YES];
	[self.controlPanel orderFront:self];

}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	DWLog(@"%@", aController);
	[super windowControllerDidLoadNib:aController];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidResizeNotification object:mainWindow];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidBecomeKeyNotification object:mainWindow];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateControlPanelPosition:) name:NSWindowDidUpdateNotification object:mainWindow];

	mainView.doc = self;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	// Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
	// You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	@throw exception;
	return nil;
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError
{
	DWLog(@"Opening %@", url);
	DWVideoClock * newClock = [[DWVideoClock alloc] initWithUrl:url];
	if (newClock != nil) {
		self.clock = newClock;
		[self.clock addObserver:self forKeyPath:@"currentFrame" options:0 context:nil];	
		[self.clock addObserver:self forKeyPath:@"state" options:0 context:nil];
	}
    return newClock != nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"currentFrame"]) {
		self.txtCurrentTC.stringValue = self.clock.tcString;
	}
	else if ([keyPath isEqualToString:@"state"]) {
		if (self.clock.state == kDWVideoClockStateReady) {
			videoView.player = clock.player;
			self.txtCurrentTC.stringValue = self.clock.tcString;
		}
	}
}

-(void)playPause {
	if (clock.rate == 0) {
		clock.rate = 1;
	}
	else {
		clock.rate = 0;
	}
}

-(void)shuttle:(double)delta {
	clock.rate += delta / 100;
}


- (IBAction)play:(id)sender {
	DWLog(@"play at %@", clock.tcString);
	self.clock.rate = 1;
	
}

- (IBAction)pause:(id)sender {
	DWLog(@"pause at %@", clock.tcString);
	self.clock.rate = 0;
}

- (IBAction)fastForward:(id)sender {
	self.clock.rate = 10;
}

- (IBAction)reverse:(id)sender {
	self.clock.rate = -1;
}

- (IBAction)rewind:(id)sender {
	self.clock.rate = -10;
}
@end
