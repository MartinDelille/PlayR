//
//  DWControlPanelWindowController.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 18/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWControlPanelWindowController.h"
#import "DWVideo/DWVideoClock.h"

@interface DWControlPanelWindowController ()

@end

@implementation DWControlPanelWindowController

@synthesize clockController;
@synthesize syncStatusString;
@synthesize refStatusString;

- (id)init
{
    self = [super initWithWindowNibName:@"DWControlPanelWindowController"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(DWVideoClock*)clock {
	return (DWVideoClock*)clockController.content;
}

- (IBAction)rewind:(id)sender {
	[[self clock] setRate:-[[NSUserDefaults standardUserDefaults] doubleForKey:@"DWSonyRewindFastForwardSpeed"] ];
}

- (IBAction)reverse:(id)sender {
	[[self clock] setRate:-1 ];
}

- (IBAction)stop:(id)sender {
	[[self clock] setRate:0 ];
}

- (IBAction)play:(id)sender {
	[[self clock] setRate:1 ];
}

- (IBAction)fastForward:(id)sender {
	[[self clock] setRate:[[NSUserDefaults standardUserDefaults] doubleForKey:@"DWSonyRewindFastForwardSpeed"] ];
}
@end
