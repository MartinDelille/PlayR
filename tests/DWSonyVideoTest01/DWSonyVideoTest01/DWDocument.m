//
//  DWDocument.m
//  DWSonyVideoTest01
//
//  Created by Martin Delille on 11/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWDocument.h"
#import "DWSony/DWSonySlaveController.h"

@implementation DWDocument {
	DWVideoClock * clock;
	DWSonySlaveController * sony;
}

@synthesize videoView;

- (id)init
{
	DWLog(@"");
    self = [super init];
    if (self) {
		clock = [[DWVideoClock alloc] init];
    }
    return self;
}

-(void)dealloc {
	[sony stop];
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"DWDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	DWLog(@"");
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
		
	clock.currentReference = nil;
	self.videoView.player = clock.player;

	sony = [[DWSonySlaveController alloc] init];
	if (sony != nil) {
		sony.clock = clock;
		[sony start];
	}
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

-(BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
	DWLog(@"Opening %@", url);
	return [clock loadWithUrl:url];
}

@end
