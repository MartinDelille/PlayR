//
//  DWAppDelegate.h
//  DWSonyMasterTest01
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *currentTCText;

@property (weak) IBOutlet NSTextField *txtStatus0;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;

@end
