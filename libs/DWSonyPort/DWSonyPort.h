//
//  DWSonyPort.h
//  DWSonyPort
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSerialPort/AMSerialPort.h"

@interface DWSonyPort : NSObject {
	AMSerialPort * port;
}

-(BOOL)initWithDevicePath:(NSString*)devicePath;
-(BOOL)readCommand:(unsigned char *)cmd1 cmd2:(unsigned char *)cmd2 data:(unsigned char *)data;
-(BOOL)sendCommand:(unsigned char)cmd1 cmd2:(unsigned char)cmd2 data:(unsigned char *)data;
-(BOOL)sendCommand2:(unsigned char)cmd1 cmd2:(unsigned char)cmd2, ...;
-(BOOL)sendAck;
-(BOOL)sendNak:(unsigned char)error;

@end
