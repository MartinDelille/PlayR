//
//  DWSonyMasterController.h
//  DWSony
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"

@interface DWSonyMasterController : DWSonyController

-(id)initWithClock:(DWClock *)aClock;
-(void)play;
-(void)stop;
-(void)fastForward;
-(void)rewind;
-(void)jog:(double)rate;
-(void)checkTime;
-(void)checkStatus;

-(void)processAnswer;

@end
