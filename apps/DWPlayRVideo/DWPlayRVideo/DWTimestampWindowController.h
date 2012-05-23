//
//  DWTimestampWindowController.h
//  DWPlayRVideo
//
//  Created by Martin Delille on 23/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DWTimestampWindowController : NSWindowController
@property (weak) IBOutlet NSButton *okButton;
- (IBAction)doOk:(id)sender;
- (IBAction)doCancel:(id)sender;

@property NSString* tcString;

@end
