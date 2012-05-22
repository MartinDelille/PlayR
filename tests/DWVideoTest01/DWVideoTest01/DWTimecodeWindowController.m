//
//  DWTimecodeWindowController.m
//  DWVideoTest01
//
//  Created by Martin Delille on 22/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimecodeWindowController.h"

@interface DWTimecodeWindowController ()

@end

@implementation DWTimecodeWindowController
@synthesize btnOk;
@synthesize tcString;

- (id)init
{
    self = [super initWithWindowNibName:@"DWTimecodeWindowController"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.window.defaultButtonCell = self.btnOk.cell;
}

- (IBAction)onOk:(id)sender {
	[self.window close];
	[NSApp stopModalWithCode:1];
}

- (IBAction)onCancel:(id)sender {
	[self.window close];
	[NSApp stopModalWithCode:0];
}
@end
