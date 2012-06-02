//
//  DWSonyController.m
//  DWSony
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWSonyController.h"
#import "DWTools/DWBCDTool.h"

@implementation DWSonyController {
	BOOL looping;
}

@synthesize clock;

-(id)initWithRef:(NSString*)ref {
	self = [super init];
	port = [[DWSonyPort alloc] initWithRef:ref];
	if (port == nil) {
		DWSonyLog(@"Sony port unavailable");
		return nil;
	}

	clock = nil;
	port.ctsHandler = self;
	looping = NO;


	return self;
}

-(void)boolEvent:(BOOL)b {
	BOOL syncOnCTSUp = [[NSUserDefaults standardUserDefaults] boolForKey:@"DWSonySyncOnCTSUp"];
	if (b== syncOnCTSUp) {
		[self.clock tickFrame:self];
	}
}

-(double)computeRateWithData1:(unsigned char)data1 {
	double n1 = data1;
	return pow(10, n1/32 - 2);
}

-(double)computeRateWithData1:(unsigned char)data1 andData2:(unsigned char)data2 {
	double n1 = data1;
	double n2 = data2;
	double rate = [self computeRateWithData1:data1];
	return rate + n2/256 * pow(10, (n1+1)/32 - 2 - rate);
}

-(unsigned char)computeData1WithRate:(double)rate {
	return (unsigned char)(32*(2+log10(rate)));
}

-(unsigned char)statusAtIndex:(int)index {
	return status[index];
}

-(void)start {
	if (!looping) {
		looping = YES;
		[NSThread detachNewThreadSelector:@selector(loopThread) toTarget:self withObject:nil];
	}
}

-(void)stop {
	looping = NO;
}

-(void)loopThread {
	@autoreleasepool {
		DWSonyLog(@"Starting sony controller loop");
		[[NSThread currentThread] setName:@"DWSonyControllerThread"];
		unsigned char data[256];
		while (looping) {
			unsigned char cmd1, cmd2;
			if([port readCommand:&cmd1 cmd2:&cmd2 data:data]) {
				[self processCmd1:cmd1 andCmd2:cmd2 withData:data];
			}
		}
		
		DWSonyLog(@"Sony controller loop over");
	}
}

-(void)processCmd1:(unsigned char)cmd1 andCmd2:(unsigned char)cmd2 withData:(const unsigned char*)dataIn {
	
}


@end
