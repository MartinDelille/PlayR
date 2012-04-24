//
//  DWAppDelegate.h
//  DWTimeCodePlayer
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWClocking/DWClock.h"

@interface DWAppDelegate : NSObject <NSApplicationDelegate>
@property DWClock * clock;

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *tcText;
- (IBAction)nextFrame:(id)sender;

@end
