//
//  DWClock.h
//  DWClocking
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTime.h"

@interface DWClock : NSObject
@property DWTime * time;
@property DWTime * timePerTick;

-(void)tick;

@end
