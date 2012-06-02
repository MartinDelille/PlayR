//
//  DWSonyPort.h
//  DWSony
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTools/DWBoolEventHandler.h"

/** Handles Sony port protocole
 
 Provide method to access a Sony serial port and write and read command from it.
 
 */
@interface DWSonyPort : NSObject

/** 
 Initialize and open a sony USB serial port.
 @param ref The USB serial reference ("A" or "B").
 @return An initialized sony serial port.
 */
-(id)initWithRef:(NSString*)ref;

/**
 Read a command and its associated data.
 @param cmd1 Indicate the command category id and the data count.
 @param cmd2 Indicate the subcommand id.
 @param data The buffer containing the command data.
 @return NO if an error occured.
 */
-(BOOL)readCommand:(unsigned char *)cmd1 cmd2:(unsigned char *)cmd2 data:(unsigned char *)data;

/**
 Send a command and its associated data.
 @param cmd1 Indicate the command category id and the data count.
 @param cmd2 Indicate the subcommand id.
 @param data The buffer containing the command data.
 @return NO if an error occured.
 */
-(BOOL)sendCommand:(unsigned char)cmd1 cmd2:(unsigned char)cmd2 data:(const unsigned char *)data;

/**
 Send a command and its associated data as a list of unsigned char value.
 @param cmd1 Indicate the command category id and the data count.
 @param cmd2 Indicate the subcommand id.
 @return NO if an error occured.
 */
-(BOOL)sendCommandWithArgument:(unsigned char)cmd1 cmd2:(unsigned char)cmd2, ...;

/**
 Send a acknlodgement command.
 @return NO if an error occured.
 */
-(BOOL)sendAck;

/**
 Send a NAK command.
 @param error Code about the NAK.
 @return NO if an error occured.
 */
-(BOOL)sendNak:(unsigned char)error;

/**
 This delegate proceeds the CTS event
 */
@property id<DWBoolEventHandler> ctsHandler;

@end
