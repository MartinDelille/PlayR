//
//  DWTimestampWindowController.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 23/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimestampWindowController.h"

@interface DWTimestampWindowController ()

@end

@implementation DWTimestampWindowController

@synthesize okButton;
@synthesize tcString;


- (id)init
{
    self = [super initWithWindowNibName:@"DWTimestampWindowController"];
    if (self) {
        [self.window setDefaultButtonCell:[okButton cell]];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)doOk:(id)sender {
	DWLog(@"%@", self.tcString);
	[self.window close];
	[NSApp stopModalWithCode:1];
}

- (IBAction)doCancel:(id)sender {
	DWLog(@"");
	[self.window close];
	[NSApp stopModalWithCode:0];
}
@end
