//
//  DWSonyController.h
//  DWSony
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWClock.h"

@interface DWSonyController : NSObject

-(id)initWithBSDPath:(NSString*)bsdPath andClock:(DWClock*)aClock;
-(void)start;
-(void)processCommand;
-(void)stop;
@end
