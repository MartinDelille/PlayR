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


@implementation DWSonyPort{
	AMSerialPort * port;
	int videoRefState;
}

@synthesize videoRefDelegate;

-(id)init {
	self = [super init];
	videoRefState = -1;
	videoRefDelegate = nil;
	
	return self;
}

-(id)initWithDevicePath:(NSString *)devicePath {
	self = [self init];
	port = [[AMSerialPort alloc] init:devicePath withName:devicePath type:NULL];
	if(port == nil) {
		NSLog(@"Error during serial port initialisation");
		return nil;
	}
	if (![port open]) {
		NSLog(@"Unable to open %@", devicePath);
		return nil;
	}
		
	NSDictionary * options = [[NSDictionary alloc] initWithObjectsAndKeys:
							  devicePath, AMSerialOptionServiceName,
							  @"38400", AMSerialOptionSpeed,
							  @"8", AMSerialOptionDataBits,
							  @"Odd", AMSerialOptionParity,
							  @"1", AMSerialOptionStopBits, nil];
	[port setOptions:options];
	return self;
}

-(void)dealloc{
	[port close];
	port = NULL;
}

-(void)checkVideoRef {
	if((videoRefState < 1) && port.CTS)
	{
		videoRefState = 1;
		[self.videoRefDelegate tick];
	}
	else {
		videoRefState = 0;
	}
}

-(unsigned char)getDataCount:(unsigned char)cmd {
	return cmd & 0x0f;
}

-(BOOL)readCommand:(unsigned char *)cmd1 cmd2:(unsigned char *)cmd2 data:(unsigned char *)data {
	NSError * error;
	
	[self checkVideoRef];
	
	// Reading the command
	NSData * tmp = [port readBytes:2 error:&error];
	if([tmp length] < 2) {
		NSLog(@"Unable to read command: %@", [error description]);
		return NO;
	}
	unsigned char* ptr = (unsigned char*)[tmp bytes];
	*cmd1 = ptr[0];
	*cmd2 = ptr[1];
	unsigned char datacount = [self getDataCount:*cmd1];
	
	// Reading the data
	tmp = [port readBytes:datacount+1 error:&error];
	if ([tmp length] < datacount+1) {
		NSLog(@"Unable to read data: %@", [error description]);
		return NO;
	}
	
	ptr = (unsigned char*)[tmp bytes];
	// Computing the checksum
	unsigned char checksum = *cmd1 + *cmd2;
	for (int i=0; i<datacount; i++) {
		checksum += ptr[i];
	}
	if (checksum != ptr[datacount]) {
		NSLog(@"Checksum error");
		[self sendNak:0x02];
		return NO;
	}
	
	// Copying the data
	for (int i=0; i<datacount; i++) {
		data[i] = ptr[i];
	}
	return YES;
}

-(BOOL)sendCommand:(unsigned char)cmd1 cmd2:(unsigned char)cmd2 data:(unsigned char *)data {
	unsigned char datacount = [self getDataCount:cmd1];
	unsigned char * buffer = (unsigned char*)malloc(datacount+3);
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
		NSLog(@"Error during writing: %@", [error description]);
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
