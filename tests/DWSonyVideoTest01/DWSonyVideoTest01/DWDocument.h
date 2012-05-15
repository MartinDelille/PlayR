//
//  DWDocument.h
//  DWSonyVideoTest01
//
//  Created by Martin Delille on 11/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWVideo/DWVideoView.h"
#import "DWVideo/DWVideoClock.h"

/** Document controller for a single video file
 
 Load a video file and connect it to a sony controller.
 
 */
@interface DWDocument : NSDocument
/** 
 The main document view.
 */
@property (weak) IBOutlet DWVideoView *videoView;
/** 
 The video clock.
 */
@property DWVideoClock * clock;
@end
