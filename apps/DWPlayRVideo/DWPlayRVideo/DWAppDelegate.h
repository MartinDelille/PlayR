//
//  DWAppDelegate.h
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWVideo/DWVideoView.h"
#import "DWVideo/DWVideoClock.h"
#import "DWPlayRWindow.h"

@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet DWPlayRWindow *window;
@property (weak) IBOutlet DWVideoView *videoView;
@property (weak) IBOutlet DWVideoClock *clock;
@property (unsafe_unretained) IBOutlet NSPanel *preferencesPanel;

- (IBAction)playPause;

-(void)showControlPanel;
-(void)showControlPanelAndHide;
-(void)hideControlPanel;
- (IBAction)changeTimestamp:(id)sender;
- (IBAction)clearTimestampDatabase:(id)sender;
- (IBAction)showPreferences:(id)sender;
- (IBAction)changeDelayUnit:(id)sender;

@end
