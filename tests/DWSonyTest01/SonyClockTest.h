//
//  SonyClockTest.h
//  DWSonyTest01
//
//  Created by Martin Delille on 19/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWSonyPort/DWSonyPort.h"

@interface SonyClockTest : NSObject<Ticking>
-(void)tick;

@end
