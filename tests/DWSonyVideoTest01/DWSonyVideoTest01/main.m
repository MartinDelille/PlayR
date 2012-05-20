//
//  main.m
//  DWSonyVideoTest01
//
//  Created by Martin Delille on 11/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
//	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic];
	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic | kDWLogLevelSonyDetails1];
	DWLog(@"");

	return NSApplicationMain(argc, (const char **)argv);
}
