//
//  DWInternalReference.h
//  DWClocking
//
//  Created by Martin Delille on 01/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWReference.h"

@interface DWInternalReference : NSObject<DWReference>

@property DWClock * clock;
@property NSTimeInterval interval;

-(id)initWithClock:(DWClock*)aClock;

-(void)start;
-(void)stop;

@end
