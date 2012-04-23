//
//  DWTickable.h
//  DWClocking
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTime.h"

@protocol DWTickable <NSObject>
-(void)tick:(DWTime)interval;
@end
