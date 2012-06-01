//
//  DWAppDelegate.m
//  DWSonyTest03
//
//  Created by Martin Delille on 01/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWClocking/DWInternalReference.h"
#import "DWClocking/DWVSyncReference.h"


@implementation DWAppDelegate {
	DWInternalReference * ref1;
	DWVSyncReference * ref2;
}


@synthesize window = _window;
@synthesize clock1;
@synthesize clock2;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	ref1 = [[DWInternalReference alloc] initWithClock:self.clock1];
	self.clock1.currentReference = ref1;
	self.clock1.tcString = @"01:00:00:00";
	self.clock1.rate = 1;
	[ref1 start];
	
	ref2 = [[DWVSyncReference alloc] init];
	ref2.clock = clock2;
	self.clock2.currentReference = ref2;
	self.clock2.tcString = @"01:00:00:00";
	self.clock2.rate = 1;
	[ref2 start];
}

@end
