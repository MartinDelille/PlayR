//
//  DWVideoView.h
//  DWVideo
//
//  Created by Martin Delille on 11/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

/** The video view
 
 Display the video corresponding to a AVPlayer object.
 */
@interface DWVideoView : NSView

/** 
 AVPlayer of the current video.
 */
@property AVPlayer * player;

@end
