//
//  DWSonyMasterController.m
//  DWSony
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyMasterController.h"
#import "DWClocking/DWTimeCode.h"
#import "DWTools/DWBCDTool.h"

@implementation DWSonyMasterController

-(id)initWithClock:(DWClock *)aClock {
	self = [super initWithClock:aClock andRef:@"B"];
	if (self == nil) {
		return nil;
	}
	
	return self;
}

-(void)play {
	DWSonyLog(@"Play");
	[port sendCommand:0x20 cmd2:0x01 data:nil];
	[self checkAck];
}

-(void)stop {
	DWSonyLog(@"Stop");
	[port sendCommand:0x20 cmd2:0x00 data:nil];
	[self checkAck];
}

-(BOOL)checkAck {
	unsigned char cmd1, cmd2;
	[port readCommand:&cmd1 cmd2:&cmd2 data:buffer];
	if ((cmd1 == 0x10) && (cmd2 == 0x01)) {
		DWSonyLog(@" => ACK");
		return YES;
	}
	else if	((cmd1 == 0x11) && (cmd2 == 0x12)) {
		DWSonyLog(@" => NAK", buffer[0]);
	}
	else {
		DWSonyLog(@" => Unknown answer : %.2X %.2X", cmd1, cmd2);		
	}
	return NO;
}

-(void)checkTime {
	DWSonyLog(@"checkTime");
	buffer[0] = 1;
	[port sendCommand:0x61 cmd2:0x0c data:buffer];
	unsigned char cmd1, cmd2;
	[port readCommand:&cmd1 cmd2:&cmd2 data:buffer];
	if ((cmd1 == 0x74) && (cmd2 == 0x04)) {
		unsigned int ff = [DWBCDTool uintFromBcd:buffer[0]];
		unsigned int ss = [DWBCDTool uintFromBcd:buffer[1]];
		unsigned int mm = [DWBCDTool uintFromBcd:buffer[2]];
		unsigned int hh = [DWBCDTool uintFromBcd:buffer[3]];
		clock.tcString = [DWTimeCode stringFromFrame:[DWTimeCode frameFromHh:hh Mm:mm Ss:ss Ff:ff andType:clock.type] andType:clock.type];
		DWSonyLog(@" => ACK");
	}
	else {
		DWSonyLog(@" => Unknown answer : %.2X %.2X", cmd1, cmd2);		
	}
}

-(void)checkStatus {
	// TODO
}

@end
