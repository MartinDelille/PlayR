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
				port.readTimeout = 0.005;
				
				DWLog(@"CTS: %d", [port CTSOutputFlowControl]);
				port.CTSOutputFlowControl = YES;
				DWLog(@"CTS: %d", [port CTSOutputFlowControl]);
				
				NSString *s;
				BOOL refState = NO;
				for (int i=0; i<40; i++) {
					s = [port readStringUsingEncoding:NSUTF8StringEncoding error:nil];
					if (s!=nil) {
						DWLog(@"reading %@", s);
					}
					BOOL cts = port.CTS;
					if (cts != refState) {
						refState = cts;
						DWLog(@"cts : %d", cts);
					}
				}
				
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

