//
//  DWSonyPort.m
//  DWSonyPort
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyPort.h"
#import "AMSerialPort/AMSerialPort.h"
#import "AMSerialPort/AMSerialPortAdditions.h"
#import "AMSerialPort/AMSerialPortList.h"
#import "DWTools/DWLogger.h"

@implementation DWSonyPort{
	AMSerialPort * port;
	BOOL lastCts;
	unsigned char * buffer;
}

@synthesize ctsHandler;

-(id)initWithRef:(NSString*)ref {
	self = [super init];
	ctsHandler = nil;
	buffer = malloc(256);
	
	NSArray * portList = [[AMSerialPortList sharedPortList] serialPorts];
	for (int i=0; i<portList.count; i++) {
		NSString* name = [[portList objectAtIndex:i] name];
		if ([name hasPrefix:@"usbserial"] && [name hasSuffix:ref]) {
			port = [portList objectAtIndex:i];
			break;
		}
	}
	
	if (port == nil) {
		DWSonyLog(@"No usbserial port B available");
	}

	if (![port open]) {
		DWSonyLog(@"Unable to open %@", port.name);
		return nil;
	}
	
	lastCts = port.CTS;
	port.readTimeout = 0.005;
	NSDictionary * options = [[NSDictionary alloc] initWithObjectsAndKeys:
							  port.name, AMSerialOptionServiceName,
							  @"38400", AMSerialOptionSpeed,
							  @"8", AMSerialOptionDataBits,
							  @"Odd", AMSerialOptionParity,
							  @"1", AMSerialOptionStopBits, nil];
	[port setOptions:options];
	[port flushInput:YES output:YES];
	return self;
}

-(void)dealloc{
	free(buffer);
	[port close];
	port = NULL;
}

-(void)checkCts {
	BOOL cts = port.CTS;
	if(lastCts != cts) {
		[self.ctsHandler boolEvent:cts];
	}
	lastCts = cts;
}

-(unsigned char)getDataCount:(unsigned char)cmd {
	return cmd & 0x0f;
}

-(NSString*)stringWithCmd1:(unsigned char) cmd1 cmd2:(unsigned char)cmd2 data:(unsigned char *)data {
	NSString * result = [NSString stringWithFormat:@"%.2X %.2X", cmd1, cmd2];
	for (int i = 0; i < [self getDataCount:cmd1] + 1; i++) {
		result = [NSString stringWithFormat:@"%@ %.2X", result, data[i]];
	}
	return result;
}

-(BOOL)readCommand:(unsigned char *)cmd1 cmd2:(unsigned char *)cmd2 data:(unsigned char *)data {
	NSError * error;
	
	int dataRead = 0;
	int nbTry = 0;
	NSData * tmp = nil;
	
	// reading the cmd1 and cmd2
	while (dataRead < 2) {
		[self checkCts];
		tmp = [port readBytes:2-dataRead error:&error];
		if (tmp != nil) {
			unsigned char * ptr = (unsigned char*)[tmp bytes];
			for (int i = 0; i< tmp.length; i++) {
				buffer[i + dataRead] = ptr[i];
			}
			dataRead += tmp.length;
		}
		nbTry++;
		if(nbTry > 200)
		{
			DWSonyLog(@"Read time out");
			return NO;
		}
	}
	
	*cmd1 = buffer[0];
	*cmd2 = buffer[1];
	unsigned char datacount = [self getDataCount:*cmd1];
	nbTry = 0;
	
	// Reading the data
	while (dataRead < datacount + 3) {
		[self checkCts];
		tmp = [port readBytes:datacount + 3 - dataRead error:&error];
		if (tmp != nil) {
			unsigned char * ptr = (unsigned char*)[tmp bytes];
			for (int i = 0; i< tmp.length; i++) {
				buffer[i + dataRead] = ptr[i];
			}
			dataRead += tmp.length;
		}
		nbTry++;
		if(nbTry > 200)
		{
			DWSonyLog(@"Read time out");
			return NO;
		}
	}
	
	NSString * cmdString = [self stringWithCmd1:*cmd1 cmd2:*cmd2 data:buffer + 2];
	DWLogWithLevel(kDWLogLevelSonyDetails2, @"reading : %@", cmdString);
	
	// Computing the checksum
	unsigned char checksum = 0;
	for (int i=0; i<datacount + 2; i++) {
		checksum += buffer[i];
	}
	
	if (checksum != buffer[datacount+2]) {
		DWSonyLog(@"Checksum error : %@", cmdString);
		[port flushInput:YES output:YES];
		[self sendNak:0x02];
		return NO;
	}
	
	// Copying the data
	for (int i=0; i<datacount; i++) {
		data[i] = buffer[i+2];
	}
	return YES;
}

-(BOOL)sendCommand:(unsigned char)cmd1 cmd2:(unsigned char)cmd2 data:(const unsigned char *)data {
	unsigned char datacount = [self getDataCount:cmd1];
	buffer[0] = cmd1;
	buffer[1] = cmd2;
	unsigned char checksum = cmd1 + cmd2;
	for (int i=0; i<datacount; i++) {
		buffer[i+2] = data[i];
		checksum += data[i];
	}
	buffer[datacount+2] = checksum;
	NSError * error;
	if(![port writeBytes:buffer length:datacount+3 error:&error]) {
		DWSonyLog(@"Error during writing: %@", [error description]);
		return NO;
	}
	return YES;
}

-(BOOL)sendCommandWithArgument:(unsigned char)cmd1 cmd2:(unsigned char)cmd2, ... {
	unsigned char datacount = [self getDataCount:cmd1];
	unsigned char * data = (unsigned char*)malloc(datacount);
	va_list argumentList;
	va_start(argumentList, cmd2);
	for (int i=0; i<datacount; i++) {
		data[i] = (unsigned char)va_arg(argumentList, int);
	}
	va_end(argumentList);
	
	return [self sendCommand:cmd1 cmd2:cmd2 data:data];
}

-(BOOL)sendAck {
	return [self sendCommandWithArgument:0x10 cmd2:0x01];
}

-(BOOL)sendNak:(unsigned char)error {
	return [self sendCommandWithArgument:0x11 cmd2:0x12, error];
}

@end
