//
//  SonyClockTest.h
//  DWSonyTest01
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWSonyPort/DWSonyPort.h"

/** Clock test
 
 This clock test class handles only the tick from the video ref
 */
@interface SonyClockTest : NSObject<Ticking>

/** 
 Respond to the tick message by writing info on the console 
 about the last tick and average tick timing.
 */
-(void)tick;

@end
