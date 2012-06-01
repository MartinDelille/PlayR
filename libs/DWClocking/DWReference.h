//
//  DWReference.h
//  DWClocking
//
//  Created by Martin Delille on 01/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClock.h"

@protocol DWReference <NSObject>

@property DWClock * clock;

@end
