//
//  DWSonySlaveController.m
//  DWSony
//
//  Created by Martin Delille on 27/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonySlaveController.h"
#import "DWTools/DWBCDTool.h"

typedef enum {
	kDWSonyStatePause,
	kDWSonyStatePlay,
	kDWSonyStateFastForward,
	kDWSonyStateRewind,
	kDWSonyStateJog,
	kDWSonyStateVar,
	kDWSonyStateShuttle,
} DWSonyState;

@implementation DWSonySlaveController {
	BOOL autoMode;
	DWSonyState state;
}

-(id)init {
	self = [super initWithRef:@"A"];
	if (self == nil) {
		return nil;
	}
	

	autoMode = NO;
	state = kDWSonyStatePause;
	
	if ([[NSUserDefaults standardUserDefaults] valueForKey:@"SonyRewindFastForwardSpeed"] == nil) {
		[[NSUserDefaults standardUserDefaults] setDouble:10 forKey:@"SonyRewindFastForwardSpeed"];
	}
	
	if ([[NSUserDefaults standardUserDefaults] valueForKey:@"SonySyncOnCTSUp"] == nil) {
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SonySyncOnCTSUp"];
	}
	
	return self;
}

-(void)processCmd1:(unsigned char)cmd1 andCmd2:(unsigned char)cmd2 withData:(const unsigned char *)dataIn {
	unsigned char dataOut[16];
	switch (cmd1 >> 4) {
		case 0:
			switch (cmd2) {
				case 0x0c:
					DWSonyLog(@"Local disable => ACK");
					[port sendAck];
					break;
				case 0x11:
				{
					DWLogWithLevel(kDWLogLevelSonyDetails1, @"Device Type Request => F1C0");
					// TODO : Device ID as a parameter
					unsigned char deviceID1 = 0xf0;
					unsigned char deviceID2 = 0xc0;
					switch (self.clock.type) {
						case kDWTimeCode2398:
						case kDWTimeCode24:
							deviceID1 += 2;
							break;
						case kDWTimeCode25:
							deviceID1 += 1;
							break;
						case kDWTimeCode2997:
							break;
					}
					[port sendCommandWithArgument:0x12 cmd2:0x11, deviceID1, deviceID2];
					break;
				}
				case 0x1d:
					DWSonyLog(@"Local enable => ACK");
					[port sendAck];
					break;
					
				default:
					DWSonyLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
					[port sendNak:0x00];
					break;
			}
			break;
		case 2:
			switch (cmd2) {
				case 0x00:
					DWSonyLog(@"Stop => ACK");
					state = kDWSonyStatePause;
					self.clock.rate = 0;
					[port sendAck];
					break;
				case 0x01:
					DWSonyLog(@"Play => ACK");
					state = kDWSonyStatePlay;
					self.clock.rate = 1;
					[port sendAck];
					break;
				case 0x10:
					DWSonyLog(@"Fast forward => ACK");
					state = kDWSonyStateFastForward;
					self.clock.rate = [[NSUserDefaults standardUserDefaults] doubleForKey:@"SonyRewindFastForwardSpeed"];
					[port sendAck];
					break;
				case 0x20:
					DWSonyLog(@"Rewing => ACK");
					state = kDWSonyStateRewind;
					self.clock.rate = -[[NSUserDefaults standardUserDefaults] doubleForKey:@"SonyRewindFastForwardSpeed"];
					[port sendAck];
					break;
				case 0x11:
				case 0x12:
				case 0x13:
				case 0x21:
				case 0x22:
				case 0x23:
				{
					double rate = 0;
					switch (cmd1 & 0xf) {
						case 1:
							rate = [self computeRateWithData1:dataIn[0]];
							break;
						case 2:
							rate = [self computeRateWithData1:dataIn[0] andData2:dataIn[1]];
							break;
					}
					switch (cmd1) {
						case 0x11:
							state = kDWSonyStateJog;
							DWSonyLog(@"Jog Forward : %.2f => ACK", rate);
							break;
						case 0x12:
							state = kDWSonyStateVar;
							DWSonyLog(@"Var Forward : %.2f => ACK", rate);
							break;
						case 0x13:
							state = kDWSonyStateShuttle;
							DWSonyLog(@"Shuttle Forward : %.2f => ACK", rate);
							break;
						case 0x21:
							rate = -rate;
							state = kDWSonyStateJog;
							DWSonyLog(@"Jog rev : %.2f => ACK", rate);
							break;
						case 0x22:
							rate = -rate;
							state = kDWSonyStateVar;
							DWSonyLog(@"Var rev : %.2f => ACK", rate);
							break;
						case 0x23:
							rate = -rate;
							state = kDWSonyStateShuttle;
							DWSonyLog(@"Shuttle rev : %.2f => ACK", rate);
							break;
					}
					self.clock.rate = rate;
					[port sendAck];
					break;
				}
				case 0x31:
				{
					unsigned char hh = [DWBCDTool bcdFromUInt:dataIn[3]];
					unsigned char mm = [DWBCDTool bcdFromUInt:dataIn[2]];
					unsigned char ss = [DWBCDTool bcdFromUInt:dataIn[1]];
					unsigned char ff = [DWBCDTool bcdFromUInt:dataIn[0]];
					self.clock.frame = [DWTimeCode frameFromHh:hh Mm:mm Ss:ss Ff:ff andType:self.clock.type];
					DWSonyLog(@"Cue at %@ => ACK", self.clock.tcString);
					[port sendAck];
					break;
				}
				default:
					DWSonyLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
					[port sendNak:0x00];
					break;
			}
			break;
		case 4:
			switch (cmd2) {
				case 0x40:
					autoMode = NO;
					DWSonyLog(@"Auto Mode Off => ACK");
					[port sendAck];
					break;
				case 0x41:
					autoMode = YES;
					DWSonyLog(@"Auto Mode On => ACK");
					[port sendAck];
					break;
				default:
					DWSonyLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
					[port sendNak:0x00];
					break;
			}
		case 6:
			switch (cmd2) {
				case 0x0c:
				{
					DWLogWithLevel(kDWLogLevelSonyDetails1, @"Current Time Sense => %@", self.clock.tcString);
					dataOut[0] = 0x74;
					switch (dataIn[0]) {
						case 0x01:
							cmd2 = 0x04;
							break;
						case 0x02:
							cmd2 = 0x06;
							break;
						case 0x04:
							cmd2 = 0x00;
							break;
						case 0x08:
							cmd2 = 0x01;
							break;
						case 0x10:
							cmd2 = 0x05;
							break;
						case 0x20:
							cmd2 = 0x07;
							break;
						default:
							cmd2 = 0x04;
							break;
					}
					unsigned int hh, mm, ss, ff;
					[DWTimeCode ComputeHh:&hh Mm:&mm Ss:&ss Ff:&ff fromFrame:self.clock.frame andType:self.clock.type];
					hh = [DWBCDTool bcdFromUInt:hh];
					mm = [DWBCDTool bcdFromUInt:mm];
					ss = [DWBCDTool bcdFromUInt:ss];
					ff = [DWBCDTool bcdFromUInt:ff];
					[port sendCommandWithArgument:0x74 cmd2:cmd2, ff, ss, mm, hh];
					break;
				}
				case 0x20:
				{
					// TODO : handle status sens properly
					DWLogWithLevel(kDWLogLevelSonyDetails1, @"Status Sense (%x) => Status Data", dataIn[0]);
					memset(status, 0, 8);
					
					switch (state) {
						case kDWSonyStatePause:
							status[1] = 0x80;
							status[2] = 0x03;
							break;
						case kDWSonyStatePlay:
							status[1] = 0x81;
							status[2] = 0xc0;
							break;
						case kDWSonyStateFastForward:
							status[1] = 0x84;
							break;
						case kDWSonyStateRewind:
							status[1] = 0x88;
							status[2] = 0x04;
							break;
						case kDWSonyStateJog:
							status[1] = 0x80;
							if (self.clock.rate < 0) {
								status[2] = 0x14;
							}
							else {
								status[2] = 0x10;
							}
							break;
						case kDWSonyStateVar:
							status[1] = 0x80;
							if (self.clock.rate < 0) {
								status[2] = 0xcc;
							}
							else {
								status[2] = 0xc8;
							}
							break;
						case kDWSonyStateShuttle:
							status[1] = 0x80;
							if (self.clock.rate < 0) {
								status[2] = 0x20;
							}
							else {
								status[2] = 0xa4;
							}
							break;
					}
					
					if (autoMode) {
						status[3] = 0x80;
					}
					
					// TODO check status with usb422v test
					unsigned char start = dataIn[0] >> 4;
					unsigned char count = dataIn[0] & 0xf;
					for (int i=0; i<count; i++) {
						dataOut[i] = status[i+start];
					}
					[port sendCommand:(0x70+count) cmd2:0x20 data:dataOut];
					break;
				}
				case 0x30:
				{
					// TODO : handle properly
					DWLogWithLevel(kDWLogLevelSonyDetails1, @"Edit Preset Sense => Edit Preset Status");
					unsigned char count = dataIn[0];
					for (int i=0; i<count; i++) {
						dataOut[i] = 0;
					}
					[port sendCommand:0x70 + count cmd2:0x30 data:dataOut];
					break;
				}									
				default:
					DWSonyLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
					[port sendNak:0x00];
					break;
			}
			break;
		default:
			DWSonyLog(@"Unknown command : %x => NAK", cmd1);
			[port sendNak:0x00];
			break;
	}
}

@end
