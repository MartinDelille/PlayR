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

int main(int argc, const char * argv[])
{

	@autoreleasepool {
		DWLog(@"SerialTest02");
		NSString * deviceName = @"/dev/cu.usbserial-00001004A";
		AMSerialPort * port = [[AMSerialPort alloc] init:deviceName withName:deviceName type:NULL];
		
		DWLog(@"Opening serial port");
		if([port open]){
			DWLog(@"CTS: %d", [port CTSOutputFlowControl]);
			port.CTSOutputFlowControl = YES;
			DWLog(@"CTS: %d", [port CTSOutputFlowControl]);
			
			DWLog(@"Reading data...");
			NSString * s = [port readStringUsingEncoding:NSUTF8StringEncoding error:nil];
//			[port writeString:@"pouet" usingEncoding:NSUTF8StringEncoding error:NULL];
			DWLog(@"read : %@", s);
			DWLog(@"Closing serial port");
			[port close];
		}
		else {
			DWLog(@"Unable to open serial port");
		}
	    
		DWLog(@"Bye bye");
	}
    return 0;
}

