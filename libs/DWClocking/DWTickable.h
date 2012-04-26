//
//  DWTickable.h
//  DWClocking
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Protocol for external clock synchronisation
 
 Define a protocol for allowing a class to send tick to a clock.
 */
@protocol DWTickable <NSObject>

/** 
 Tell the tickable object that one frame has elapsed.
 */
-(void)tickFrame;
@end
