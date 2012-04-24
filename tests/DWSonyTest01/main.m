//
//  main.m
//  DWSonyTest01
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTools/DWLogger.h"
#import "DWSony/DWSonyPort.h"
#import "DWClocking/DWClock.h"
#import "DWTimeCode/DWTimeCode.h"

int main(int argc, const char * argv[])
{
	@autoreleasepool {
	    
		[DWLogger configureOutput:@"/Users/martindelille/test.log"];
		//[DWLogger configure:1 fileName:nil showDate:YES showTime:NO showFile:NO showFunc:NO];
	    DWLog(@"DWSonyTest01");
				
		NSString * devicePath = @"/dev/cu.usbserial-00002006B";
		DWSonyPort *sony = [[DWSonyPort alloc] initWithDevicePath:devicePath];
		if(sony != nil) {
			DWClock * clock = [[DWClock alloc] init];
			clock.rate = 0;
			sony.videoRefDelegate = clock;
			unsigned char cmd1, cmd2;
			unsigned char buffer[256];
			BOOL looping = YES;
			while (looping) {
				if([sony readCommand:&cmd1 cmd2:&cmd2 data:buffer]) {
					switch (cmd1 >> 4) {
						case 0:
							switch (cmd2) {
								case 0x0c:
									DWLog(@"Local disable => ACK");
									[sony sendAck];
									break;
								case 0x11:
									DWLog(@"Device Type Request => F1C0");
									[sony sendCommandWithArgument:0x12 cmd2:0x11, 0xf1, 0xc0];
									break;
								case 0x1d:
									DWLog(@"Local enable => ACK");
									[sony sendAck];
									break;
									
								default:
									DWLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
									[sony sendNak:0x00];
									looping = NO;
									break;
							}
							break;
						case 2:
							switch (cmd2) {
								case 0x00:
									DWLog(@"Play => ACK");
									clock.rate = 0;
									[sony sendAck];
									break;
								case 0x01:
									DWLog(@"Play => ACK");
									clock.rate = 1;
									[sony sendAck];
									break;
								default:
									DWLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
									[sony sendNak:0x00];
									looping = NO;
									break;
							}
							break;
						case 6:
							switch (cmd2) {
								case 0x0c:
								{
									// TODO : handle properly
									DWTimeCode *tc = [[DWTimeCode alloc] initWithTime:clock.time andType:kDWTimeCode25];
									DWLog(@"Current Time Sense => %@", tc.string);
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
									[tc getHh:&hh Mm:&mm Ss:&ss Ff:&ff];
									[sony sendCommandWithArgument:0x74 cmd2:cmd2, ff, ss, mm, hh];
									break;
								}
								case 0x20:
								{
									// TODO : handle properly
									DWLog(@"Status Sense (%x) => Status Data", buffer[0]);
									unsigned char count = buffer[0] & 0xf;
									for (int i=0; i<count; i++) {
										buffer[i] = 0;
									}
									[sony sendCommand:(0x70+count) cmd2:0x20 data:buffer];
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
									[sony sendCommand:0x70 + count cmd2:0x30 data:buffer];
									break;
								}									
								default:
									DWLog(@"Unknown subcommand : %x %x => NAK", cmd1, cmd2);
									[sony sendNak:0x00];
									looping = NO;
									break;
							}
							break;
						default:
							DWLog(@"Unknown command : %x => NAK", cmd1);
							[sony sendNak:0x00];
							looping = NO;
							break;
					}

				}
				else {
					DWLog(@"Error during reading");
				//	looping = NO;
				}
			}
		}
		DWLog(@"Bye, bye");
		[DWLogger configureOutput:nil];	    
	}
    return 0;
}

