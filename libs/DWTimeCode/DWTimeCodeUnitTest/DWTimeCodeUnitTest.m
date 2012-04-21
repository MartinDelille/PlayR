//
//  DWTimeCodeUnitTest.m
//  DWTimeCodeUnitTest
//
//  Created by Martin Delille on 21/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimeCodeUnitTest.h"
#import "DWTimeCode.h"

@implementation DWTimeCodeUnitTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTC2398StringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2398];
	
	STAssertEqualObjects(@"00:00:00:00", tc.string, nil);
	tc.frame = 1;
	STAssertEqualObjects(@"00:00:00:01", tc.string, nil);
	tc.frame = 23;
	STAssertEqualObjects(@"00:00:00:23", tc.string, nil);
	tc.frame = 24;
	STAssertEqualObjects(@"00:00:01:00", tc.string, nil);
	tc.frame = 47;
	STAssertEqualObjects(@"00:00:01:23", tc.string, nil);
	tc.frame = 48;
	STAssertEqualObjects(@"00:00:02:00", tc.string, nil);
	tc.frame = 1439;
	STAssertEqualObjects(@"00:00:59:23", tc.string, nil);
	tc.frame = 1440;
	STAssertEqualObjects(@"00:01:00:00", tc.string, nil);
	tc.frame = 2879;
	STAssertEqualObjects(@"00:01:59:23", tc.string, nil);
	tc.frame = 2880;
	STAssertEqualObjects(@"00:02:00:00", tc.string, nil);
	tc.frame = 4319;
	STAssertEqualObjects(@"00:02:59:23", tc.string, nil);
	tc.frame = 4320;
	STAssertEqualObjects(@"00:03:00:00", tc.string, nil);
	tc.frame = 14399;
	STAssertEqualObjects(@"00:09:59:23", tc.string, nil);
	tc.frame = 14400;
	STAssertEqualObjects(@"00:10:00:00", tc.string, nil);
	tc.frame = 14401;
	STAssertEqualObjects(@"00:10:00:01", tc.string, nil);
	tc.frame = 15839;
	STAssertEqualObjects(@"00:10:59:23", tc.string, nil);
	tc.frame = 15840;
	STAssertEqualObjects(@"00:11:00:00", tc.string, nil);
}

- (void)testTC24StringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode24];
	
	STAssertEqualObjects(@"00:00:00:00", tc.string, nil);
	tc.frame = 1;
	STAssertEqualObjects(@"00:00:00:01", tc.string, nil);
	tc.frame = 23;
	STAssertEqualObjects(@"00:00:00:23", tc.string, nil);
	tc.frame = 24;
	STAssertEqualObjects(@"00:00:01:00", tc.string, nil);
	tc.frame = 47;
	STAssertEqualObjects(@"00:00:01:23", tc.string, nil);
	tc.frame = 48;
	STAssertEqualObjects(@"00:00:02:00", tc.string, nil);
	tc.frame = 1439;
	STAssertEqualObjects(@"00:00:59:23", tc.string, nil);
	tc.frame = 1440;
	STAssertEqualObjects(@"00:01:00:00", tc.string, nil);
	tc.frame = 2879;
	STAssertEqualObjects(@"00:01:59:23", tc.string, nil);
	tc.frame = 2880;
	STAssertEqualObjects(@"00:02:00:00", tc.string, nil);
	tc.frame = 4319;
	STAssertEqualObjects(@"00:02:59:23", tc.string, nil);
	tc.frame = 4320;
	STAssertEqualObjects(@"00:03:00:00", tc.string, nil);
	tc.frame = 14399;
	STAssertEqualObjects(@"00:09:59:23", tc.string, nil);
	tc.frame = 14400;
	STAssertEqualObjects(@"00:10:00:00", tc.string, nil);
	tc.frame = 14401;
	STAssertEqualObjects(@"00:10:00:01", tc.string, nil);
	tc.frame = 15839;
	STAssertEqualObjects(@"00:10:59:23", tc.string, nil);
	tc.frame = 15840;
	STAssertEqualObjects(@"00:11:00:00", tc.string, nil);
}

- (void)testTC25StringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode25];
	
	STAssertEqualObjects(@"00:00:00:00", tc.string, nil);
	tc.frame = 1;
	STAssertEqualObjects(@"00:00:00:01", tc.string, nil);
	tc.frame = 24;
	STAssertEqualObjects(@"00:00:00:24", tc.string, nil);
	tc.frame = 25;
	STAssertEqualObjects(@"00:00:01:00", tc.string, nil);
	tc.frame = 49;
	STAssertEqualObjects(@"00:00:01:24", tc.string, nil);
	tc.frame = 50;
	STAssertEqualObjects(@"00:00:02:00", tc.string, nil);
	tc.frame = 1499;
	STAssertEqualObjects(@"00:00:59:24", tc.string, nil);
	tc.frame = 1500;
	STAssertEqualObjects(@"00:01:00:00", tc.string, nil);
	tc.frame = 2999;
	STAssertEqualObjects(@"00:01:59:24", tc.string, nil);
	tc.frame = 3000;
	STAssertEqualObjects(@"00:02:00:00", tc.string, nil);
	tc.frame = 4499;
	STAssertEqualObjects(@"00:02:59:24", tc.string, nil);
	tc.frame = 4500;
	STAssertEqualObjects(@"00:03:00:00", tc.string, nil);
	tc.frame = 14999;
	STAssertEqualObjects(@"00:09:59:24", tc.string, nil);
	tc.frame = 15000;
	STAssertEqualObjects(@"00:10:00:00", tc.string, nil);
	tc.frame = 15001;
	STAssertEqualObjects(@"00:10:00:01", tc.string, nil);
	tc.frame = 16499;
	STAssertEqualObjects(@"00:10:59:24", tc.string, nil);
	tc.frame = 16500;
	STAssertEqualObjects(@"00:11:00:00", tc.string, nil);
}

- (void)testTC2997StringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2997];
	
	STAssertEqualObjects(@"00:00:00:00", tc.string, nil);
	tc.frame = 1;
	STAssertEqualObjects(@"00:00:00:01", tc.string, nil);
	tc.frame = 2;
	STAssertEqualObjects(@"00:00:00:02", tc.string, nil);
	tc.frame = 29;
	STAssertEqualObjects(@"00:00:00:29", tc.string, nil);
	tc.frame = 30;
	STAssertEqualObjects(@"00:00:01:00", tc.string, nil);
	tc.frame = 59;
	STAssertEqualObjects(@"00:00:01:29", tc.string, nil);
	tc.frame = 60;
	STAssertEqualObjects(@"00:00:02:00", tc.string, nil);
	tc.frame = 1799;
	STAssertEqualObjects(@"00:00:59:29", tc.string, nil);
	tc.frame = 1800;
	STAssertEqualObjects(@"00:01:00:02", tc.string, nil);
	tc.frame = 3597;
	STAssertEqualObjects(@"00:01:59:29", tc.string, nil);
	tc.frame = 3598;
	STAssertEqualObjects(@"00:02:00:02", tc.string, nil);
	tc.frame = 5395;
	STAssertEqualObjects(@"00:02:59:29", tc.string, nil);
	tc.frame = 5396;
	STAssertEqualObjects(@"00:03:00:02", tc.string, nil);
	tc.frame = 7193;
	STAssertEqualObjects(@"00:03:59:29", tc.string, nil);
	tc.frame = 7194;
	STAssertEqualObjects(@"00:04:00:02", tc.string, nil);
	tc.frame = 17981;
	STAssertEqualObjects(@"00:09:59:29", tc.string, nil);
	tc.frame = 17982;
	STAssertEqualObjects(@"00:10:00:00", tc.string, nil);
	tc.frame = 17983;
	STAssertEqualObjects(@"00:10:00:01", tc.string, nil);
	tc.frame = 19781;
	STAssertEqualObjects(@"00:10:59:29", tc.string, nil);
	tc.frame = 19782;
	STAssertEqualObjects(@"00:11:00:02", tc.string, nil);
}

@end
