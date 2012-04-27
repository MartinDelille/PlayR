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
#import "DWSony/DWSonyController.h"
#import "DWClocking/DWClock.h"
#import "DWClocking/DWTimeCode.h"

int main(int argc, const char * argv[])
{
	@autoreleasepool {
	    
		//[DWLogger configureOutput:@"/Users/martindelille/test.log"];
		//[DWLogger configure:1 fileName:nil showDate:YES showTime:NO showFile:NO showFunc:NO];
		[DWLogger configureLogLevel:kDWLogLevelBasic | kDWLogLevelSonyBasic | kDWLogLevelSonyDetails];
	    DWLog(@"DWSonyTest01");
		DWLogWithLevel(kDWLogLevelSonyBasic, @"test log level");
		DWLogWithLevel(kDWLogLevelTest, @"test log level 2");
		
				
/*		NSString * devicePath = @"/dev/cu.usbserial-00002006B";
		DWClock * clock = [[DWClock alloc] init];
		DWSonyController *sony = [[DWSonyController alloc] initWithBSDPath:devicePath andClock:clock];
		
		if(sony != nil) {
			clock.rate = 0;
			clock.tcString = @"01:00:00:00";
//			sony.videoRefDelegate = clock;
			BOOL looping = NO;
			while (looping) {
				[sony processCommand];
			}
		}*/
		[DWLogger configureOutput:nil];
		DWLog(@"Bye, bye");
	}
    return 0;
}

