//
//  DWVideoTestView.h
//  DWVideoTest01
//
//  Created by Martin Delille on 14/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideo/DWVideoView.h"

@class DWDocument;

/** Main application video
	
 Display the video.
 Handles user input:
 * keyboard
 * mouse event
 */
@interface DWVideoTestView : DWVideoView

/** 
 Main application controller.
 */
@property DWDocument* doc;

@end
