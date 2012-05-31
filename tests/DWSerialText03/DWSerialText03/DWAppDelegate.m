//
//  DWAppDelegate.m
//  DWSerialText03
//
//  Created by Martin Delille on 31/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import "AMSerialPort/AMSerialPort.h"
#import "AMSerialPort/AMSerialPortList.h"

@implementation DWAppDelegate

@synthesize window = _window;
@synthesize stringList;

-(void)portChanged:(NSNotification*) aNotification {
	NSString * newList = @"";
	
	for (AMSerialPort * port in [[AMSerialPortList sharedPortList] serialPorts] ) {
		newList = [NSString stringWithFormat:@"%@%@\n", newList, port.name];
	}
	self.stringList = newList;

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self portChanged:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(portChanged:) name:AMSerialPortListDidAddPortsNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(portChanged:) name:AMSerialPortListDidRemovePortsNotification object:nil];
	
}

@end
