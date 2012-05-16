//
//  main.m
//  DWPlayRVideo
//
//  Created by Martin Delille on 16/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
	[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic | kDWLogLevelSonyDetails1];
	return NSApplicationMain(argc, (const char **)argv);
}
