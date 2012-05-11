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

@interface DWDocument : NSDocument
@property (weak) IBOutlet DWVideoView *videoView;
@property DWVideoClock * clock;
@end
