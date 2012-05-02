//
//  main.m
//  DWSerialTest02
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTools/DWLogger.h"
#import "AMSerialPort/AMSerialPort.h"
#import "AMSerialPort/AMSerialPortAdditions.h"
#import "AMSerialPort/AMSerialPortList.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
		[DWLogger configureDisplay:NO showTime:YES showFile:NO showFunc:NO];
		DWLog(@"SerialTest02");
		NSArray * portList = [[AMSerialPortList sharedPortList] serialPorts];
		AMSerialPort * port = nil;
		for (int i=0; i<portList.count; i++) {
			NSString* name = [[portList objectAtIndex:i] name];
			if ([name hasPrefix:@"usbserial"] && [name hasSuffix:@"A"]) {
				port = [portList objectAtIndex:i];
				break;
			}
		}

		if (port == nil) {
			DWLog(@"No usbserial port A available");
		}
		else {
			DWLog(@"Opening serial port");
			if([port open]){
				[port flushInput:YES output:YES];
				port.readTimeout = 10;
				
				DWLog(@"CTS: %d", [port CTSOutputFlowControl]);
				port.CTSOutputFlowControl = YES;
				DWLog(@"CTS: %d", [port CTSOutputFlowControl]);
				
				//BOOL refState = NO;
		//		for (int i=0; i<40; i++) {
/*					NSData * data = [port readBytes:8 error:nil];
					if (data!=nil) {
						unsigned char *ptr = (unsigned char*)[data bytes];
						NSString * dataStr = @"";
						for (int j=0; j<data.length; j++) {
							dataStr = [NSString stringWithFormat:@"%@ %.2X", dataStr, ptr[j]];
						}
						DWLog(@"reading %d bytes : %@", data.length, dataStr);
					}*/
//					NSString *s = [port readStringUsingEncoding:NSUTF8StringEncoding error:nil];
					NSString *s = [port readUpToChar:'s' usingEncoding:NSUTF8StringEncoding error:nil];
					if (s!=nil) {
						DWLog(@"reading %@", s);
					}
					else {
						DWLog(@"timeout");
					}
		/*			BOOL cts = port.CTS;
					if (cts != refState) {
						refState = cts;
						DWLog(@"cts : %d", cts);
					}*/
		//		}
				
				DWLog(@"Writing data...");
				[port writeString:@"pouet" usingEncoding:NSUTF8StringEncoding error:NULL];
				DWLog(@"Closing serial port");
				[port close];
			}
			else {
				DWLog(@"Unable to open serial port");
			}
		}
	    
		DWLog(@"Bye bye");
	}
    return 0;
}

