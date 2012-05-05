//
//  DWDocument.m
//  DWVideoTest01
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWDocument.h"
#import "DWTools/DWLogger.h"

@implementation DWDocument

@synthesize videoView;
@synthesize txtCurrentTC;
@synthesize clock;

- (id)init
{
    self = [super init];
    if (self) {
		// Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"DWDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
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

- (IBAction)play:(id)sender {
	[clock tickFrame];
	DWLog(@"play at %@", clock.tcString);
	self.clock.rate = 1;
	
}

- (IBAction)pause:(id)sender {
	[clock tickFrame];
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
