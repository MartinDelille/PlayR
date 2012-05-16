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

-(id)init {
	self = [super initWithRef:@"B"];
	if (self == nil) {
		return nil;
	}
	
	return self;
}

-(void)play {
	DWSonyLog(@"Play");
	[port sendCommand:0x20 cmd2:0x01 data:nil];
	[self processAnswer];
}

-(void)stop {
	DWSonyLog(@"Stop");
	[port sendCommand:0x20 cmd2:0x00 data:nil];
	[self processAnswer];
}

-(void)fastForward {
	DWSonyLog(@"Fast forward");
	[port sendCommand:0x20 cmd2:0x10 data:nil];
	[self processAnswer];
}

-(void)rewind {
	DWSonyLog(@"Rewind");
	[port sendCommand:0x20 cmd2:0x20 data:nil];
	[self processAnswer];
}

-(void)jog:(double)rate {
	DWSonyLog(@"Jog %.2f", rate);
	if (rate < 0) {
		buffer[0] = [super computeData1WithRate:-rate];
		[port sendCommand:0x21 cmd2:0x21 data:buffer];
	}
	else {
		buffer[0] = [super computeData1WithRate:rate];
		[port sendCommand:0x21 cmd2:0x11 data:buffer];
	}
	[self processAnswer];
}

-(void)varispeed:(double)rate {
	DWSonyLog(@"Varispeed %.2f", rate);
	if (rate < 0) {
		buffer[0] = [super computeData1WithRate:-rate];
		[port sendCommand:0x21 cmd2:0x22 data:buffer];
	}
	else {
		buffer[0] = [super computeData1WithRate:rate];
		[port sendCommand:0x21 cmd2:0x12 data:buffer];
	}
	[self processAnswer];
}

-(void)shuttle:(double)rate {
	DWSonyLog(@"Shuttle %.2f", rate);
	if (rate < 0) {
		buffer[0] = [super computeData1WithRate:-rate];
		[port sendCommand:0x21 cmd2:0x23 data:buffer];
	}
	else {
		buffer[0] = [super computeData1WithRate:rate];
		[port sendCommand:0x21 cmd2:0x13 data:buffer];
	}
	[self processAnswer];
}

-(void)timeSense {
	DWLogWithLevel(kDWLogLevelSonyDetails1, @"Time sense");
	buffer[0] = 1;
	[port sendCommand:0x61 cmd2:0x0c data:buffer];
	[self processAnswer];
}

-(void)statusSense {
	DWLogWithLevel(kDWLogLevelSonyDetails1, @"Status sense");
	buffer[0] = 4;
	[port sendCommand:0x61 cmd2:0x20 data:buffer];
	[self processAnswer];
}

-(void)processAnswer {
	unsigned char cmd1, cmd2;
	if([port readCommand:&cmd1 cmd2:&cmd2 data:buffer]) {
		switch (cmd1 >> 4) {
			case 1:
				switch (cmd2) {
					case 0x01:
						DWSonyLog(@" => ACK");
						break;
					case 0x12:
						DWSonyLog(@" => NAK : %.2X", buffer[0]);
						break;
					default:
						DWSonyLog(@" => Unknown answer : %.2X %.2X", cmd1, cmd2);
						break;
				}
				break;
			case 7:
				switch (cmd2) {
					case 0x04:
					{
						unsigned int ff = [DWBCDTool uintFromBcd:buffer[0]];
						unsigned int ss = [DWBCDTool uintFromBcd:buffer[1]];
						unsigned int mm = [DWBCDTool uintFromBcd:buffer[2]];
						unsigned int hh = [DWBCDTool uintFromBcd:buffer[3]];
						self.clock.tcString = [DWTimeCode stringFromFrame:[DWTimeCode frameFromHh:hh Mm:mm Ss:ss Ff:ff andType:self.clock.type] andType:self.clock.type];
						DWLogWithLevel(kDWLogLevelSonyDetails1, @" => LTC Time Data : %@", self.clock.tcString);
						break;
					}
					case 0x20:
					{
						NSString * statusStr = @"";
						for (int i=0; i<4; i++) {
							status[i] = buffer[i];
							statusStr = [NSString stringWithFormat:@"%@ %.2X", statusStr, buffer[i]];
						}
						DWLogWithLevel(kDWLogLevelSonyDetails1, @" => Status data : %@", statusStr);
						break;
					}
					default:
						DWLogWithLevel(kDWLogLevelSonyDetails1, @" => Unknown answer : %.2X %.2X", cmd1, cmd2);
						break;
				}
				break;
			default:
				DWSonyLog(@" => Unknown answer : %.2X %.2X", cmd1, cmd2);
				break;
		}
	}
}
				
@end
