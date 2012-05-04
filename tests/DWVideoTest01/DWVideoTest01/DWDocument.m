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

@synthesize txtCurrentTC = _txtCurrentTC;
@synthesize movie = _movie;
@synthesize clock = _clock;

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

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
/*	NSNumber *num = [NSNumber numberWithBool:YES];
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								absoluteURL, QTMovieURLAttribute, 
								//num, QTMovieLoopsAttribute,
								num, QTMovieOpenForPlaybackAttribute,
								nil];
	
	QTMovie *newMovie = [[QTMovie alloc] initWithAttributes:attributes error:outError];
*/	
	QTMovie *newMovie = [QTMovie movieWithURL:absoluteURL error:outError];
	if (newMovie) {
        self.movie = newMovie;
		self.clock = [[DWVideoClock alloc] initWithMovie:self.movie];
		
		NSTimer * frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self.clock selector:@selector(tickFrame) userInfo:nil repeats:YES];	
		NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
		[runLoop addTimer:frameTimer forMode:NSDefaultRunLoopMode];
		
		[self.clock addObserver:self forKeyPath:@"time" options:0 context:nil];

	}
    return (newMovie != nil);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	self.txtCurrentTC.stringValue = self.clock.tcString;
}

- (IBAction)play:(id)sender {
	self.movie.rate = 1;
	
}

- (IBAction)pause:(id)sender {
	self.movie.rate = 0;
}

- (IBAction)fastForward:(id)sender {
	self.movie.rate = 10;
}

- (IBAction)reverse:(id)sender {
	self.movie.rate = -1;
}

- (IBAction)rewind:(id)sender {
	self.movie.rate = -10;
}
@end
