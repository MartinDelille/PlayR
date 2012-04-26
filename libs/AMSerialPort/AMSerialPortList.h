//
//  AMSerialPortList.h
//
//  Created by Andreas on 2002-04-24.
//  Copyright (c) 2001 Andreas Mayer. All rights reserved.
//
//  2002-09-09 Andreas Mayer
//  - reuse AMSerialPort objects when calling init on an existing AMSerialPortList
//  2002-09-30 Andreas Mayer
//  - added +sharedPortList
//  2004-02-10 Andreas Mayer
//  - added +portEnumerator
//  2006-08-16 Andreas Mayer
//  - added methods dealing with ports of a certain serial type
//  - renamed -getSerialPorts to -serialPorts - moved old declaration to Deprecated category
//  2007-05-22 Nick Zitzmann
//  - added notifications for when serial ports are added/removed
//  2007-10-26 Sean McBride
//  - made code 64 bit and garbage collection clean

#import "AMSDKCompatibility.h"

#import <Foundation/Foundation.h>

// For constants clients will want to pass to methods that want a 'serialTypeKey'
#import <IOKit/serial/IOSerialKeys.h>
// note: the constants are C strings, so use '@' or CFSTR to convert, for example:
// NSArray *ports = [[AMSerialPort sharedPortList] serialPortsOfType:@kIOSerialBSDModemType];
// NSArray *ports = [[AMSerialPort sharedPortList] serialPortsOfType:(NSString*)CFSTR(kIOSerialBSDModemType)];

@class AMSerialPort;

extern NSString * const AMSerialPortListDidAddPortsNotification;
extern NSString * const AMSerialPortListDidRemovePortsNotification;
extern NSString * const AMSerialPortListAddedPorts;
extern NSString * const AMSerialPortListRemovedPorts;

/** List available serial port
 
 Provide a list of all the supported serial port.
 */
@interface AMSerialPortList : NSObject
{
@private
	NSMutableArray *portList;
}

/** 
 Singleton instance of the port list
 @return A singleton instance of the port list
 */
+ (AMSerialPortList *)sharedPortList;

/** 
 The port enumerator
 @return An enumerator
 */
+ (NSEnumerator *)portEnumerator;

/** 
 The port enumerator for a specific type.
 @param serialTypeKey A type of port
 @return An enumerator
 */
+ (NSEnumerator *)portEnumeratorForSerialPortsOfType:(NSString *)serialTypeKey;

/** 
 Number of supported serial port.
 */
@property(readonly) NSUInteger count;

/** 
 Get the port at a specific index
 @param idx An index in the list
 @return The corresponding port
 */
- (AMSerialPort *)objectAtIndex:(NSUInteger)idx;

/** 
 Get the port with a specific name
 @param name A name
 @return The corresponding port
 */
- (AMSerialPort *)objectWithName:(NSString *)name;

/** 
 Get the current list of port
 */
@property(readonly) NSArray * serialPorts;

/** 
 Get the list of port from a specific type
 @param serialTypeKey A type of port
 @return A list of ports
 */
- (NSArray *)serialPortsOfType:(NSString *)serialTypeKey;

@end
