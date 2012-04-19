//
//  AMSerialPortAdditions.h
//
//  Created by Andreas on Thu May 02 2002.
//  Copyright (c) 2001-2009 Andreas Mayer. All rights reserved.
//
//  2002-10-04 Andreas Mayer
//  - readDataInBackgroundWithTarget:selector: and writeDataInBackground: added
//  2002-10-10 Andreas Mayer
//	- stopWriteInBackground added
//  2002-10-17 Andreas Mayer
//	- numberOfWriteInBackgroundThreads added
//  2002-10-25 Andreas Mayer
//	- readDataInBackground and stopReadInBackground added
//  2004-02-10 Andreas Mayer
//    - replaced notifications for background reading/writing with direct messages to delegate
//      see informal protocol
//  2004-08-18 Andreas Mayer
//	- readStringOfLength: added (suggested by Michael Beck)
//  2006-08-16 Andreas Mayer / Sean McBride
//	- changed interface for blocking read/write access significantly
//	- fixed -checkRead and renamed it to -bytesAvailable
//	- see AMSerialPort_Deprecated for old interfaces
//  2007-10-26 Sean McBride
//  - made code 64 bit and garbage collection clean
//  2009-05-08 Sean McBride
//  - added writeBytes:length:error: method

#import "AMSDKCompatibility.h"

#import <Foundation/Foundation.h>
#import "AMSerialPort.h"

/** Handle additionnal serial port communication
 
 Provide method to read and write data to the serial port.
 */
@interface AMSerialPort (AMSerialPortAdditions)

/**
 Returns the number of bytes available in the input buffer
 Be careful how you use this information, it may be out of date just after you get it
 */
@property(readonly) int bytesAvailable;

//- (void)waitForInput:(id)target selector:(SEL)selector;

/**
 Read some data and returns after [self readTimout] seconds elapse, at the latest.
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSData *)readAndReturnError:(NSError **)error;

/**
 Read some data.
 @param bytes number of byte to read
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSData *)readBytes:(NSUInteger)bytes error:(NSError **)error;

/**
 Read some data up to a char.
 @param stopChar: when encountered no more data is read.
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSData *)readUpToChar:(char)stopChar error:(NSError **)error;

/**
 Read some data up to a char.
 @param bytes number of byte to read
 @param stopChar: when encountered no more data is read.
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSData *)readBytes:(NSUInteger)bytes upToChar:(char)stopChar error:(NSError **)error;

/**
 Read some data and convert it into an NSString, using the given encoding
 NOTE: encodings that take up more than one byte per character may fail if only a part of the final string was received
 @param encoding to use.
 @param error pointer to the error information.
 @return NSString contained the data read.
 */
- (NSString *)readStringUsingEncoding:(NSStringEncoding)encoding error:(NSError **)error;

/**
 Read some data and convert it into an NSString, using the given encoding
 @param bytes number of byte to read
 @param encoding to use.
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSString *)readBytes:(NSUInteger)bytes usingEncoding:(NSStringEncoding)encoding error:(NSError **)error;

/**
 Read some data and convert it into an NSString, using the given encoding
 @param stopChar: when encountered no more data is read. 'stopChar' has to be a byte value, using the given encoding; you can not wait for an arbitrary character from a multi-byte encoding
 @param encoding to use.
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSString *)readUpToChar:(char)stopChar usingEncoding:(NSStringEncoding)encoding error:(NSError **)error;

/**
 Read some data and convert it into an NSString, using the given encoding
 @param bytes number of byte to read
 @param stopChar: when encountered no more data is read. 'stopChar' has to be a byte value, using the given encoding; you can not wait for an arbitrary character from a multi-byte encoding
 @param encoding to use.
 @param error pointer to the error information.
 @return NSData contained the data read.
 */
- (NSString *)readBytes:(NSUInteger)bytes upToChar:(char)stopChar usingEncoding:(NSStringEncoding)encoding error:(NSError **)error;

/**
 Write to the serial port.
 @param data to write.
 @param error pointer to the error information.
 @return NO if an error occured
 */
- (BOOL)writeData:(NSData *)data error:(NSError **)error;

/**
 Write to the serial port.
 @param string to write
 @param encoding to use.
 @param error pointer to the error information.
 @return NO if an error occured
 */
- (BOOL)writeString:(NSString *)string usingEncoding:(NSStringEncoding)encoding error:(NSError **)error;

/**
 Write to the serial port.
 @param bytes buffer to write
 @param length of the buffer
 @param error pointer to the error information.
 @return NO if an error occured
 */
- (BOOL)writeBytes:(const void *)bytes length:(NSUInteger)length error:(NSError **)error;

/**
 Will send serialPortReadData: to delegate
 the dataDictionary object will contain these entries:
 1. "serialPort": the AMSerialPort object that sent the message
 2. "data": (NSData *)data - received data
 */
- (void)readDataInBackground;

/**
 Stop read data in background.
 */
- (void)stopReadInBackground;

/**
 Will send serialPortWriteProgress: to delegate if task lasts more than
 approximately three seconds.
 the dataDictionary object will contain these entries:
 1. "serialPort": the AMSerialPort object that sent the message
 2. "value": (NSNumber *)value - bytes sent
 3. "total": (NSNumber *)total - bytes total
 @param data to write
 */
- (void)writeDataInBackground:(NSData *)data;

/**
 Stop write data in background.
 */
- (void)stopWriteInBackground;

/**
 Get the number of write in background threads.
 */
@property(readonly) int numberOfWriteInBackgroundThreads;

@end
