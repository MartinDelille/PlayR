//
//  main.m
//  DWClockingTest01
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWClocking/DWTime.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    NSLog(@"DWClockingTest01");
		
		DWTime* t = [[DWTime alloc] initWithTime:5 andScale:600];
		NSLog(@"We have a %@", [t description]);
	    
	}
    return 0;
}

