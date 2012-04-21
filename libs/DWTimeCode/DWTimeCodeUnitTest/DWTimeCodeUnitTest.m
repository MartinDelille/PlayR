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

- (void)testTC2398SetStringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2398];
	
	tc.string = @"00:00:00:00";
	STAssertEquals((unsigned int)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((unsigned int)1, tc.frame, nil);
	tc.string = @"00:00:00:23";
	STAssertEquals((unsigned int)23, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((unsigned int)24, tc.frame, nil);
	tc.string = @"00:00:01:23";
	STAssertEquals((unsigned int)47, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((unsigned int)48, tc.frame, nil);
	tc.string = @"00:00:59:23";
	STAssertEquals((unsigned int)1439, tc.frame, nil);
	tc.string = @"00:01:00:00";
	STAssertEquals((unsigned int)1440, tc.frame, nil);
	tc.string = @"00:01:59:23";
	STAssertEquals((unsigned int)2879, tc.frame, nil);
	tc.string = @"00:02:00:00";
	STAssertEquals((unsigned int)2880, tc.frame, nil);
	tc.string = @"00:02:59:23";
	STAssertEquals((unsigned int)4319, tc.frame, nil);
	tc.string = @"00:03:00:00";
	STAssertEquals((unsigned int)4320, tc.frame, nil);
	tc.string = @"00:09:59:23";
	STAssertEquals((unsigned int)14399, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((unsigned int)14400, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((unsigned int)14401, tc.frame, nil);
	tc.string = @"00:10:59:23";
	STAssertEquals((unsigned int)15839, tc.frame, nil);
	tc.string = @"00:11:00:00";
	STAssertEquals((unsigned int)15840, tc.frame, nil);
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

- (void)testTC24SetStringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode24];
	
	tc.string = @"00:00:00:00";
	STAssertEquals((unsigned int)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((unsigned int)1, tc.frame, nil);
	tc.string = @"00:00:00:23";
	STAssertEquals((unsigned int)23, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((unsigned int)24, tc.frame, nil);
	tc.string = @"00:00:01:23";
	STAssertEquals((unsigned int)47, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((unsigned int)48, tc.frame, nil);
	tc.string = @"00:00:59:23";
	STAssertEquals((unsigned int)1439, tc.frame, nil);
	tc.string = @"00:01:00:00";
	STAssertEquals((unsigned int)1440, tc.frame, nil);
	tc.string = @"00:01:59:23";
	STAssertEquals((unsigned int)2879, tc.frame, nil);
	tc.string = @"00:02:00:00";
	STAssertEquals((unsigned int)2880, tc.frame, nil);
	tc.string = @"00:02:59:23";
	STAssertEquals((unsigned int)4319, tc.frame, nil);
	tc.string = @"00:03:00:00";
	STAssertEquals((unsigned int)4320, tc.frame, nil);
	tc.string = @"00:09:59:23";
	STAssertEquals((unsigned int)14399, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((unsigned int)14400, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((unsigned int)14401, tc.frame, nil);
	tc.string = @"00:10:59:23";
	STAssertEquals((unsigned int)15839, tc.frame, nil);
	tc.string = @"00:11:00:00";
	STAssertEquals((unsigned int)15840, tc.frame, nil);
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

- (void)testTC25SetStringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode25];
	
	tc.string = @"00:00:00:00";
	STAssertEquals((unsigned int)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((unsigned int)1, tc.frame, nil);
	tc.string = @"00:00:00:24";
	STAssertEquals((unsigned int)24, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((unsigned int)25, tc.frame, nil);
	tc.string = @"00:00:01:24";
	STAssertEquals((unsigned int)49, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((unsigned int)50, tc.frame, nil);
	tc.string = @"00:00:59:24";
	STAssertEquals((unsigned int)1499, tc.frame, nil);
	tc.string = @"00:01:00:00";
	STAssertEquals((unsigned int)1500, tc.frame, nil);
	tc.string = @"00:01:59:24";
	STAssertEquals((unsigned int)2999, tc.frame, nil);
	tc.string = @"00:02:00:00";
	STAssertEquals((unsigned int)3000, tc.frame, nil);
	tc.string = @"00:02:59:24";
	STAssertEquals((unsigned int)4499, tc.frame, nil);
	tc.string = @"00:03:00:00";
	STAssertEquals((unsigned int)4500, tc.frame, nil);
	tc.string = @"00:09:59:24";
	STAssertEquals((unsigned int)14999, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((unsigned int)15000, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((unsigned int)15001, tc.frame, nil);
	tc.string = @"00:10:59:24";
	STAssertEquals((unsigned int)16499, tc.frame, nil);
	tc.string = @"00:11:00:00";
	STAssertEquals((unsigned int)16500, tc.frame, nil);
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

- (void)testTC2997SetStringTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2997];
	
	tc.string = @"00:00:00:00";
	STAssertEquals((unsigned int)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((unsigned int)1, tc.frame, nil);
	tc.string = @"00:00:00:29";
	STAssertEquals((unsigned int)29, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((unsigned int)30, tc.frame, nil);
	tc.string = @"00:00:01:29";
	STAssertEquals((unsigned int)59, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((unsigned int)60, tc.frame, nil);
	tc.string = @"00:00:59:29";
	STAssertEquals((unsigned int)1799, tc.frame, nil);
	tc.string = @"00:01:00:02";
	STAssertEquals((unsigned int)1800, tc.frame, nil);
	tc.string = @"00:01:59:29";
	STAssertEquals((unsigned int)3597, tc.frame, nil);
	tc.string = @"00:02:00:02";
	STAssertEquals((unsigned int)3598, tc.frame, nil);
	tc.string = @"00:02:59:29";
	STAssertEquals((unsigned int)5395, tc.frame, nil);
	tc.string = @"00:03:00:02";
	STAssertEquals((unsigned int)5396, tc.frame, nil);
	tc.string = @"00:03:59:29";
	STAssertEquals((unsigned int)7193, tc.frame, nil);
	tc.string = @"00:04:00:02";
	STAssertEquals((unsigned int)7194, tc.frame, nil);
	tc.string = @"00:09:59:29";
	STAssertEquals((unsigned int)17981, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((unsigned int)17982, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((unsigned int)17983, tc.frame, nil);
	tc.string = @"00:10:59:29";
	STAssertEquals((unsigned int)19781, tc.frame, nil);
	tc.string = @"00:11:00:02";
	STAssertEquals((unsigned int)19782, tc.frame, nil);
}

@end
