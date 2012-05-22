//
//  DWTimecodeWindowController.h
//  DWVideoTest01
//
//  Created by Martin Delille on 22/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWUserInterface/DWTimecodeField.h"

@interface DWTimecodeWindowController : NSWindowController
- (IBAction)onOk:(id)sender;
- (IBAction)onCancel:(id)sender;
@property (unsafe_unretained) IBOutlet NSButton *btnOk;

@property NSString * tcString;

@end
