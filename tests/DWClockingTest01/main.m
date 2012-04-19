//
//  main.m
//  DWClockingTest01
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWTime.h"
#import "DWClocking/DWClock.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    NSLog(@"DWClockingTest01");
		
		DWClock* c = [[DWClock alloc] init];
		
		c.timePerTick.Time = 40;
		NSLog(@"Clock %@", [c description]);
		
		for (int i=0; i<100; i++) {
			[NSThread sleepForTimeInterval:0.04];
			[c tick];
			NSLog(@"Clock %@", [c description]);
		}
	}
    return 0;
}

