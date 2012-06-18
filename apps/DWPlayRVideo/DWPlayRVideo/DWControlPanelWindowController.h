//
//  DWControlPanelWindowController.h
//  DWPlayRVideo
//
//  Created by Martin Delille on 18/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DWControlPanelWindowController : NSWindowController

@property (strong) IBOutlet NSObjectController *clockController;

@property NSString * syncStatusString;
@property NSString * refStatusString;

- (IBAction)rewind:(id)sender;
- (IBAction)reverse:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)fastForward:(id)sender;

@end
