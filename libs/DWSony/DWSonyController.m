//
//  DWSonyController.m
//  DWSony
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"
#import "DWSonyPort.h"
#import "DWTools/DWBCDTool.h"

@implementation DWSonyController {
	DWSonyPort * port;
	BOOL looping;
	DWClock * clock;
	unsigned char buffer[256];
}

-(id)initWithClock:(DWClock *)aClock {
	self = [self init];
	looping = NO;
	port = [[DWSonyPort alloc] init];
	if (port == nil) {
		DWSonyLog(@"Sony port unavailable");
		return nil;
	}

	clock = aClock;
	
	// TODO allow switch between internal and video reference
	port.videoRefDelegate = clock;
	
	return self;
}

-(void)loopThread {
	@autoreleasepool {
		DWSonyLog(@"Starting sony controller loop");
		
		while (looping) {
			[self processCommand];
		}
		
		DWSonyLog(@"Sony controller loop over");
	}
}

-(void)start {
	looping = YES;
	
	[NSThread detachNewThreadSelector:@selector(loopThread) toTarget:self withObject:nil];
}

-(void)stop {
	looping = NO;
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
						DWLogWithLevel(kDWLogLevelSonyDetails, @"Device Type Request => F1C0");
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
						clock.rate = 0;
						[port sendAck];
						break;
					case 0x01:
						DWSonyLog(@"Play => ACK");
						clock.rate = 1;
						[port sendAck];
						break;
					case 0x10:
						DWSonyLog(@"Fast forward => ACK");
						// TODO: speed as a parameter for fast forward speed
						clock.rate = 50;
						[port sendAck];
						break;
					case 0x20:
						DWSonyLog(@"Rewing => ACK");
						// TODO: parameter for rewind speed
						clock.rate = -50;
						[port sendAck];
						break;
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
			case 6:
				switch (cmd2) {
					case 0x0c:
					{
						DWLogWithLevel(kDWLogLevelSonyDetails, @"Current Time Sense => %@", clock.tcString);
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
						DWLogWithLevel(kDWLogLevelSonyDetails, @"Status Sense (%x) => Status Data", buffer[0]);
						unsigned char status[16];
						memset(status, 0, 16);
						
						if (clock.rate == 0) {
							status[1] = 0x80;
							status[2] = 0x03;
						}
						else if (clock.rate == 1) {
							status[1] = 0x81;
							status[2] = 0xc0;
						}
						else if (clock.rate > 1) {
							status[1] = 0x84;
						}
						else if (clock.rate < -1) {
							status[1] = 0x88;
							status[2] = 0x04;
						}
						
						// TODO handle shuttle fwd and rev
						// TODO handle varispeed fwd and rev
						// TODO handle jog fwd and rev
						// TODO handle auto mode
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
						DWLogWithLevel(kDWLogLevelSonyDetails, @"Edit Preset Sense => Edit Preset Status");
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
