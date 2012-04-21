//
//  main.m
//  DWClockingTest01
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWTimeCode/DWTimeCode.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    NSLog(@"DWClockingTest01");
		
		int start = 1798;
		for (int i=0; i<5; i++) {
			DWTimeCode * tc = [[DWTimeCode alloc] initWithFrame:start + i andType:kDWTimeCode2997];
			NSLog(@"%d => %@", start + i, [tc description]);
		}

	}
    return 0;
}

