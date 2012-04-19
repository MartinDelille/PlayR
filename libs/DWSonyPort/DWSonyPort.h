//
//  DWSonyPort.h
//  DWSonyPort
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Handle video ref change
 
 This protocol is used for video ref change in the sony protocol.
 */
@protocol Ticking

/** 
 Send a tick message to the delegate.
 */
-(void)tick;

@end


/** Handles Sony port comunication
 
 Provide method to access a Sony serial port and write and read command from it.
 
 */
@interface DWSonyPort : NSObject

/** 
 Initialize the sony port with a BSD path.
 @param devicePath is a BSD path (eg: /dev/cu.usbserial-00001004B)
 @return The initialized instance
 */
-(id)initWithDevicePath:(NSString*)devicePath;

/**
 Read a command and its associated data.
 @param cmd1 indicate the command category id and the data count
 @param cmd2: indicate the subcommand id.
 @param data buffer associated to the command
 @return NO if an error occured.
 */
-(BOOL)readCommand:(unsigned char *)cmd1 cmd2:(unsigned char *)cmd2 data:(unsigned char *)data;

/**
 Send a command and its associated data.
 @param cmd1 indicate the command category id and the data count
 @param cmd2: indicate the subcommand id.
 @param data buffer associated to the command
 @return NO if an error occured.
 */
-(BOOL)sendCommand:(unsigned char)cmd1 cmd2:(unsigned char)cmd2 data:(unsigned char *)data;

/**
 Send a command and its associated data as a list of unsigned char value.
 @param cmd1 indicate the command category id and the data count
 @param cmd2: indicate the subcommand id.
 @return NO if an error occured.
 */
-(BOOL)sendCommandWithArgument:(unsigned char)cmd1 cmd2:(unsigned char)cmd2, ...;

/**
 Send a acknlodgement command
 @return NO if an error occured.
 */
-(BOOL)sendAck;

/**
 Send a NAK command
 @param error code about the NAK.
 @return NO if an error occured.
 */
-(BOOL)sendNak:(unsigned char)error;

/** 
 This delegate proceed the video reference tick.
 */
@property id<Ticking> videoRefDelegate;

@end
