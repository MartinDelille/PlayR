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

-(id)initWithBSDPath:(NSString *)bsdPath andClock:(DWClock *)aClock {
	self = [self init];
	looping = NO;
	port = [[DWSonyPort alloc] initWithDevicePath:bsdPath];
	if (port == nil) {
		DWLog(@"Bad device path: %@", bsdPath);
		return nil;
	}

	clock = aClock;
	
	return self;
}

-(void)loopThread {
	@autoreleasepool {
		DWLog(@"Starting sony controller loop");
		
		while (looping) {
			[self processCommand];
		}
		
		DWLog(@"Sony controller loop over");
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
						DWLog(@"Local disable => ACK");
						[port sendAck];
						break;
					case 0x11:
						DWLog(@"Device Type Request => F1C0");
						[port sendCommandWithArgument:0x12 cmd2:0x11, 0xf1, 0xc0];
						break;
					case 0x1d:
						DWLog(@"Local enable => ACK");
						[port sendAck];
						break;
						
					default:
						DWLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
						[port sendNak:0x00];
						break;
				}
				break;
			case 2:
				switch (cmd2) {
					case 0x00:
						DWLog(@"Play => ACK");
						clock.rate = 0;
						[port sendAck];
						break;
					case 0x01:
						DWLog(@"Play => ACK");
						clock.rate = 1;
						[port sendAck];
						break;
					default:
						DWLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
						[port sendNak:0x00];
						break;
				}
				break;
			case 6:
				switch (cmd2) {
					case 0x0c:
					{
						DWLog(@"Current Time Sense => %@", clock.tcString);
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
						unsigned char hh, mm, ss, ff;
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
						// TODO : handle properly
						DWLog(@"Status Sense (%x) => Status Data", buffer[0]);
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
						DWLog(@"Edit Preset Sense => Edit Preset Status");
						unsigned char count = buffer[0];
						for (int i=0; i<count; i++) {
							buffer[i] = 0;
						}
						[port sendCommand:0x70 + count cmd2:0x30 data:buffer];
						break;
					}									
					default:
						DWLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
						[port sendNak:0x00];
						break;
				}
				break;
			default:
				DWLog(@"Unknown command : %x => NAK", cmd1);
				[port sendNak:0x00];
				break;
		}
		
	}
	else {
		DWLog(@"Error during reading");
	}
}
@end
