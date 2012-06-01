//
//  DWAppDelegate.h
//  DWClockingTest02
//
//  Created by Martin Delille on 01/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWClocking/DWClock.h"

@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet DWClock *clock1;
@property (weak) IBOutlet DWClock *clock2;

@end
