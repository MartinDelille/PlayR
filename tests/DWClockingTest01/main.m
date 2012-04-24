//
//  main.m
//  DWClockingTest01
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTimeCode/DWTimeCode.h"
#import "DWClocking/DWClock.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    NSLog(@"DWClockingTest01");

		DWTimeCode * tc = [[DWTimeCode alloc] initWithType:kDWTimeCode25];
		tc.string = @"00:00:00:00";
		NSLog(@"frame = %ld", tc.frame);
		
		NSLog(@" clock : %@", [[[DWClock alloc] init] description]);


	}
    return 0;
}

