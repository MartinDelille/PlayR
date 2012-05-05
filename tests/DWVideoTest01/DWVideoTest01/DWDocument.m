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
@synthesize player;
@synthesize playerItem;
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


-(void)onAssetSuccessfullyLoaded:(AVURLAsset*)asset {
	self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
	
	NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self.clock selector:@selector(tickFrame) userInfo:nil repeats:YES];	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
	
	[self.clock addObserver:self forKeyPath:@"currentFrame" options:0 context:nil];	

	// TODO
	
//	[playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];

	/*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];*/
	self.player = [AVPlayer playerWithPlayerItem:playerItem];


	videoView.player = player;
	self.clock = [[DWVideoClock alloc] initWithPlayer:player andURLAsset:asset];
	self.txtCurrentTC.stringValue = self.clock.tcString;
	
	[clock addObserver:self forKeyPath:@"time" options:0 context:nil];
}

-(void)reportError:(NSError*)error onAsset:(AVURLAsset*)asset {
	// TODO
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError
{
	DWLog(@"Opening %@", url);
	NSDictionary * options = nil;
	// TODO: check if needed
	//	options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
	AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:options];
	
	if (asset != nil) {
		NSArray *keys = [NSArray arrayWithObject:@"tracks"];
		
		[asset loadValuesAsynchronouslyForKeys:keys completionHandler:^() {
			dispatch_async(dispatch_get_main_queue(),
						   ^{
							   AVKeyValueStatus trackStatus = [asset statusOfValueForKey:@"tracks" error:outError];
							   DWLog(@"state : %d", trackStatus);
							   switch (trackStatus) {
								   case AVKeyValueStatusLoaded:
									   [self onAssetSuccessfullyLoaded:asset];
									   break;
								   case AVKeyValueStatusFailed:
									   [self reportError:*outError onAsset:asset];
									   break;
								   case AVKeyValueStatusCancelled:
									   // TODO : handle cancelation
									   break;
							   }
						   });
		}];
	}
    return asset != nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	self.txtCurrentTC.stringValue = self.clock.tcString;
}

- (IBAction)play:(id)sender {
	[clock tickFrame];
	DWLog(@"play at %@", clock.tcString);
	self.player.rate = 1;
	
}

- (IBAction)pause:(id)sender {
	[clock tickFrame];
	DWLog(@"pause at %@", clock.tcString);
	self.player.rate = 0;
}

- (IBAction)fastForward:(id)sender {
	self.player.rate = 10;
}

- (IBAction)reverse:(id)sender {
	self.player.rate = -1;
}

- (IBAction)rewind:(id)sender {
	self.player.rate = -10;
}
@end
