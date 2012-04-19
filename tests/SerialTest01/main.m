//
//  main.m
//  SerialTest01
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSerialPort/AMSerialPort.h"
#import "AMSerialPort/AMSerialPortAdditions.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    
	    // insert code here...
	    NSLog(@"SerialTest01");
		NSString * deviceName = @"/dev/cu.usbserial-00002006A";
		AMSerialPort * port = [[AMSerialPort alloc] init:deviceName withName:deviceName type:NULL];
		
		NSLog(@"Opening serial port");
		if([port open]){
			NSLog(@"CTS: %d", [port CTSOutputFlowControl]);
			port.CTSOutputFlowControl = YES;
			NSLog(@"CTS: %d", [port CTSOutputFlowControl]);
			
			NSLog(@"Writing data...");
			
			[port writeString:@"pouet" usingEncoding:NSUTF8StringEncoding error:NULL];
			NSLog(@"CTS: %d", [port CTS]);

			NSLog(@"Closing serial port");
			[port close];
		}
		else {
			NSLog(@"Unable to open serial port");
		}
	    
		NSLog(@"Bye bye");
	}
    return 0;
}

