//
//  main.m
//  DWSonyTest01
//
//  Created by Martin Delille on 03/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTools/DWLogger.h"
#import "DWSony/DWSonyPort.h"
#import "DWSony/DWSonyMasterController.h"
#import "DWClocking/DWClock.h"
#import "DWClocking/DWTimeCode.h"

int main(int argc, const char * argv[])
{
	@autoreleasepool {
	    
		//[DWLogger configureOutput:@"/Users/martindelille/test.log"];
		//[DWLogger configure:1 fileName:nil showDate:YES showTime:NO showFile:NO showFunc:NO];
		[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic | kDWLogLevelSonyDetails1];
	    DWLog(@"DWSonyTest01");
		
				
		DWClock * clock = [[DWClock alloc] init];
		DWSonyMasterController *sony = [[DWSonyMasterController alloc] init];
		sony.clock = clock;
		
		if(sony != nil) {
			[sony stop];
			[NSThread sleepForTimeInterval:0.1];
			[sony statusSense];
			DWLog(@"tc = %@", clock.tcString);
		}
		else {
			DWLog(@"error opening port");
		}
		[DWLogger configureOutput:nil];
		DWLog(@"Bye, bye");
	}
    return 0;
}

