//
//  AMSerialPort.h
//
//  Created by Andreas on 2002-04-24.
//  Copyright (c) 2001-2011 Andreas Mayer. All rights reserved.
//
//  2002-09-18 Andreas Mayer
//  - added available & owner
//  2002-10-17 Andreas Mayer
//	- countWriteInBackgroundThreads and countWriteInBackgroundThreadsLock added
//  2002-10-25 Andreas Mayer
//	- more additional instance variables for reading and writing in background
//  2004-02-10 Andreas Mayer
//    - added delegate for background reading/writing
//  2005-04-04 Andreas Mayer
//	- added setDTR and clearDTR
//  2006-07-28 Andreas Mayer
//	- added -canonicalMode, -endOfLineCharacter and friends
//	  (code contributed by Randy Bradley)
//	- cleaned up accessor methods; moved deprecated methods to "Deprecated" category
//	- -setSpeed: does support arbitrary values on 10.4 and later; returns YES on success, NO otherwiese
//  2006-08-16 Andreas Mayer
//	- cleaned up the code and removed some (presumably) unnecessary locks
//  2007-10-26 Sean McBride
//  - made code 64 bit and garbage collection clean
//  2008-10-21 Sean McBride
//  - Added an API to open a serial port for exclusive use
//  - fixed some memory management issues


/*
 * Standard speeds defined in termios.h
 *
#define B0	0
#define B50	50
#define B75	75
#define B110	110
#define B134	134
#define B150	150
#define B200	200
#define B300	300
#define B600	600
#define B1200	1200
#define	B1800	1800
#define B2400	2400
#define B4800	4800
#define B7200	7200
#define B9600	9600
#define B14400	14400
#define B19200	19200
#define B28800	28800
#define B38400	38400
#define B57600	57600
#define B76800	76800
#define B115200	115200
#define B230400	230400
 */


#import "AMSDKCompatibility.h"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <paths.h>
#include <termios.h>
#include <sys/time.h>
#include <sysexits.h>
#include <sys/param.h>

#import <Foundation/Foundation.h>

#define	AMSerialOptionServiceName @"AMSerialOptionServiceName"
#define	AMSerialOptionSpeed @"AMSerialOptionSpeed"
#define	AMSerialOptionDataBits @"AMSerialOptionDataBits"
#define	AMSerialOptionParity @"AMSerialOptionParity"
#define	AMSerialOptionStopBits @"AMSerialOptionStopBits"
#define	AMSerialOptionInputFlowControl @"AMSerialOptionInputFlowControl"
#define	AMSerialOptionOutputFlowControl @"AMSerialOptionOutputFlowControl"
#define	AMSerialOptionEcho @"AMSerialOptionEcho"
#define	AMSerialOptionCanonicalMode @"AMSerialOptionCanonicalMode"


// By default, debug code is preprocessed out.  If you would like to compile with debug code enabled,
// "#define AMSerialDebug" before including any AMSerialPort headers, as in your prefix header

typedef enum {	
	kAMSerialParityNone = 0,
	kAMSerialParityOdd = 1,
	kAMSerialParityEven = 2
} AMSerialParity;

typedef enum {	
	kAMSerialStopBitsOne = 1,
	kAMSerialStopBitsTwo = 2
} AMSerialStopBits;

// Private constant
#define AMSER_MAXBUFSIZE  4096UL

extern NSString *const AMSerialErrorDomain;

/** Category for reading/writing data in background.
 */
@interface NSObject (AMSerialDelegate)

/**
 Called when data are read in background.
 @param dataDictionary contain these entries:
 1. "serialPort": the AMSerialPort object that sent the message
 2. "data": (NSData *)data - received data
 */
- (void)serialPortReadData:(NSDictionary *)dataDictionary;
/**
 Called when data are written in background.
 @param dataDictionary object will contain these entries:
 1. "serialPort": the AMSerialPort object that sent the message
 2. "value": (NSNumber *)value - bytes sent
 3. "total": (NSNumber *)total - bytes total
 */
- (void)serialPortWriteProgress:(NSDictionary *)dataDictionary;
@end
 

/** Handle basic serial port communication
 
 Provide method to connect to the serial port and to configure it.
 */
@interface AMSerialPort : NSObject
{
@private
	NSString *bsdPath;
	NSString *serviceName;
	NSString *serviceType;
	int fileDescriptor;
	struct termios * options;
	struct termios * originalOptions;
	NSMutableDictionary *optionsDictionary;
	NSFileHandle *fileHandle;
	BOOL gotError;
	int	lastError;
	id owner;
	char * buffer;
	fd_set * readfds;
	id delegate;
	BOOL delegateHandlesReadInBackground;
	BOOL delegateHandlesWriteInBackground;
	NSLock *writeLock;
	NSLock *readLock;
	NSLock *closeLock;
	
	// used by AMSerialPortAdditions only:
	id am_readTarget;
	SEL am_readSelector;
	BOOL stopWriteInBackground;
	int countWriteInBackgroundThreads;
	BOOL stopReadInBackground;
	int countReadInBackgroundThreads;
}

/** 
 Initialize the serial port
 @param path is a bsd path
 @param path is a bsdPath
 @param name is an IOKit service name
 @param serialType is an IOKit service type
 @return The initialized serial port
 */
- (id)init:(NSString *)path withName:(NSString *)name type:(NSString *)serialType;

/** 
 BSD path (e.g. '/dev/cu.modem')
 */
@property(readonly) NSString * bsdPath;

/**
 IOKit service name (e.g. 'modem')
 */
@property(readonly) NSString * name;

/**
 IOKit service type (e.g. kIOSerialBSDRS232Type)
 */
@property(readonly) NSString * type;

/**
 IORegistry entry properties - see IORegistryEntryCreateCFProperties()
 */
@property(readonly) NSDictionary * properties;

/** 
 YES if port is open
 */
@property(readonly) BOOL isOpen;

/** 
 get this port exclusively; 
 @param sender of the message
 @return NULL if it's not free
 */
- (AMSerialPort *)obtainBy:(id)sender;

/** 
 Give it back (and close the port if still open)
 */
- (void)free;

/** 
 Check if port is free and can be obtained
 */
@property(readonly) BOOL available;

/** 
 Who obtained the port?
 */
@property(readonly) id owner;

/** 
 opens port for read and write operations, allow shared access of port
 to actually read or write data use the methods provided by NSFileHandle
 (alternatively you may use those from AMSerialPortAdditions)
 @return NSFileHandle for reading and writing
 */
- (NSFileHandle *)open;

/** 
 opens port for read and write operations, insist on exclusive access to port
 to actually read or write data use the methods provided by NSFileHandle
 (alternatively you may use those from AMSerialPortAdditions)
 @return NSFileHandle for reading and writing
 */
- (NSFileHandle *)openExclusively;

/** 
 Close port - no more read or write operations allowed
 */
- (void)close;

/** 
 Waits until all output written has been transmitted.
 @return YES if the operation succeeds.
 */
- (BOOL)drainInput;

/** 
 discards any data written which has not
 been transmitted, or any data received from the terminal but not yet read.
 @param fIn set to YES mean that the input will be flushed.
 @param fOut set to YES mean that the output will be flushed. 
 @return YES if the operation succeeds.
 */
- (BOOL)flushInput:(BOOL)fIn output:(BOOL)fOut;	// (fIn or fOut) must be YES

/** 
 transmits a continuous stream of zero-valued bits for four-tenths of a sec-
 ond to the terminal referenced by fildes. 
 The duration parameter is ignored in this implementation.
 @return YES if the operation succeeds.
 */
- (BOOL)sendBreak;

/** 
 Set DTR - not yet tested!
 @return YES if the operation succeeds
 */
- (BOOL)setDTR;

/** 
 Clear DTR - not yet tested!
 @return YES if the operation succeeds
 */
- (BOOL)clearDTR;

/** 
 Read and write serial port settings through a dictionary.
 Will open the port to get options if neccessary
 Reading and setting parameters is only useful if the serial port is already open
 When writting, AMSerialOptionServiceName HAS to match! You may NOT switch ports using this
 method.
 */
@property NSDictionary * options;

// reading and setting parameters is only useful if the serial port is already open

/** 
 Read serial port speed in bauds.
 */
@property(readonly) unsigned long speed;

/** 
 Write serial port speed.
 @param speed in bauds.
 @return NO if it failed.
 */
- (BOOL)setSpeed:(unsigned long)speed;

/** 
 Serial port data bit count from 5 to 8 (5 may not work)
 */
@property unsigned long dataBits;

/** 
 Serial port parity.
 */
@property AMSerialParity parity;

/** 
 Serial port stop bits count.
 */
@property AMSerialStopBits stopBits;

/** 
 Echo enabled.
 */
@property BOOL echoEnabled;
/** 
 Check RTS input flow control
 */
@property BOOL RTSInputFlowControl;

/** 
 DTR input flow control
 */
@property BOOL DTRInputFlowControl;

/** 
 CTS output flow control
 */
@property BOOL CTSOutputFlowControl;

/** 
 CTS state
 */
@property(readonly) BOOL CTS;

/** 
 DSR output flow control
 */
@property BOOL DSROutputFlowControl;

/** 
 CAR output flow control
 */
@property BOOL CAROutputFlowControl;

/** 
 Hand up on close
 */
@property BOOL hangupOnClose;

/** 
 Local mode
 YES = ignore modem status lines
 */
@property BOOL localMode;

/** 
 Canonical mode
 */
@property BOOL canonicalMode;

/**
 End of line character
 */
@property char endOfLineCharacter;

/** 
 Call this before changing any settings
 */
- (void)clearError;

/** 
 Call this after using any of the above properties
 @return NO if an error occured (see errorCode)
 */
- (BOOL)commitChanges;

/** 
 If -commitChanges returns NO, look here for further info
 */
@property(readonly) int errorCode;

/** 
 Delegate (for background reading/writing)
 */
@property id delegate;

/**
 Time out for blocking reads in seconds
 */
@property NSTimeInterval readTimeout;

/** 
 Read time out as a Timeval structure
 @param timeout pointer to timeval structure
 */
- (void)readTimeoutAsTimeval:(struct timeval*)timeout;

@end
