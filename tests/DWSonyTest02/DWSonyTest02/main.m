//
//  main.m
//  DWSonyTest02
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic];
	
	return NSApplicationMain(argc, (const char **)argv);
}
