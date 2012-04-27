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

-(id)initWithClock:(DWClock *)aClock {
	self = [super initWithClock:aClock andRef:@"A"];
	if (self == nil) {
		return nil;
	}
	autoMode = NO;
	state = kDWSonyStatePause;
	
	return self;
}

-(void)processCommand {
	unsigned char cmd1, cmd2;
	if([port readCommand:&cmd1 cmd2:&cmd2 data:buffer]) {
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
						switch (clock.type) {
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
						clock.rate = 0;
						[port sendAck];
						break;
					case 0x01:
						DWSonyLog(@"Play => ACK");
						state = kDWSonyStatePlay;
						clock.rate = 1;
						[port sendAck];
						break;
					case 0x10:
						DWSonyLog(@"Fast forward => ACK");
						// TODO: speed as a parameter for fast forward speed
						state = kDWSonyStateFastForward;
						clock.rate = 50;
						[port sendAck];
						break;
					case 0x20:
						DWSonyLog(@"Rewing => ACK");
						state = kDWSonyStateRewind;
						// TODO: parameter for rewind speed
						clock.rate = -50;
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
								rate = [self computeSpeedWithData1:buffer[0]];
								break;
							case 2:
								rate = [self computeSpeedWithData1:buffer[0] andData2:buffer[1]];
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
						clock.rate = rate;
						[port sendAck];
						break;
					}
					case 0x31:
					{
						unsigned char hh = [DWBCDTool bcdFromUInt:buffer[3]];
						unsigned char mm = [DWBCDTool bcdFromUInt:buffer[2]];
						unsigned char ss = [DWBCDTool bcdFromUInt:buffer[1]];
						unsigned char ff = [DWBCDTool bcdFromUInt:buffer[0]];
						clock.frame = [DWTimeCode frameFromHh:hh Mm:mm Ss:ss Ff:ff andType:clock.type];
						DWSonyLog(@"Cue at %@ => ACK", clock.tcString);
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
						DWLogWithLevel(kDWLogLevelSonyDetails1, @"Current Time Sense => %@", clock.tcString);
						buffer[0] = 0x74;
						switch (buffer[0]) {
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
						[DWTimeCode ComputeHh:&hh Mm:&mm Ss:&ss Ff:&ff fromFrame:clock.frame andType:clock.type];
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
						DWLogWithLevel(kDWLogLevelSonyDetails1, @"Status Sense (%x) => Status Data", buffer[0]);
						unsigned char status[16];
						memset(status, 0, 16);
						
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
								if (clock.rate < 0) {
									status[2] = 0x14;
								}
								else {
									status[2] = 0x10;
								}
							case kDWSonyStateVar:
								status[1] = 0x80;
								if (clock.rate < 0) {
									status[2] = 0xcc;
								}
								else {
									status[2] = 0xc8;
								}
							case kDWSonyStateShuttle:
								status[1] = 0x80;
								if (clock.rate < 0) {
									status[2] = 0x20;
								}
								else {
									status[2] = 0xa4;
								}
						}
						
						if (autoMode) {
							status[3] = 0x80;
						}
						
						// TODO check status with usb422v test
						unsigned char start = buffer[0] >> 4;
						unsigned char count = buffer[0] & 0xf;
						for (int i=0; i<count; i++) {
							buffer[i] = status[i+start];
						}
						[port sendCommand:(0x70+count) cmd2:0x20 data:buffer];
						break;
					}
					case 0x30:
					{
						// TODO : handle properly
						DWLogWithLevel(kDWLogLevelSonyDetails1, @"Edit Preset Sense => Edit Preset Status");
						unsigned char count = buffer[0];
						for (int i=0; i<count; i++) {
							buffer[i] = 0;
						}
						[port sendCommand:0x70 + count cmd2:0x30 data:buffer];
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
}

@end
