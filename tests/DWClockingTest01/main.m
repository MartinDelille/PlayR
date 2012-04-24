//
//  main.m
//  DWClockingTest01
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWClock.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    NSLog(@"DWClockingTest01");
		
		DWClock * clock = [[DWClock alloc] init];	
		clock.frame = 90000;
		NSLog(@" clock : %@", clock);


	}
    return 0;
}

