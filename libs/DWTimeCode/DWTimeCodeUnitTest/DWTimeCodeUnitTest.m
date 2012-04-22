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
	STAssertEquals((long)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((long)1, tc.frame, nil);
	tc.string = @"00:00:00:23";
	STAssertEquals((long)23, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((long)24, tc.frame, nil);
	tc.string = @"00:00:01:23";
	STAssertEquals((long)47, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((long)48, tc.frame, nil);
	tc.string = @"00:00:59:23";
	STAssertEquals((long)1439, tc.frame, nil);
	tc.string = @"00:01:00:00";
	STAssertEquals((long)1440, tc.frame, nil);
	tc.string = @"00:01:59:23";
	STAssertEquals((long)2879, tc.frame, nil);
	tc.string = @"00:02:00:00";
	STAssertEquals((long)2880, tc.frame, nil);
	tc.string = @"00:02:59:23";
	STAssertEquals((long)4319, tc.frame, nil);
	tc.string = @"00:03:00:00";
	STAssertEquals((long)4320, tc.frame, nil);
	tc.string = @"00:09:59:23";
	STAssertEquals((long)14399, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((long)14400, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((long)14401, tc.frame, nil);
	tc.string = @"00:10:59:23";
	STAssertEquals((long)15839, tc.frame, nil);
	tc.string = @"00:11:00:00";
	STAssertEquals((long)15840, tc.frame, nil);
}

- (void)testTC2398BcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2398];
	
	STAssertEquals((unsigned int)0x00000000, tc.bcd, nil);
	tc.frame = 1;
	STAssertEquals((unsigned int)0x00000001, tc.bcd, nil);
	tc.frame = 23;
	STAssertEquals((unsigned int)0x00000023, tc.bcd, nil);
	tc.frame = 24;
	STAssertEquals((unsigned int)0x00000100, tc.bcd, nil);
	tc.frame = 47;
	STAssertEquals((unsigned int)0x00000123, tc.bcd, nil);
	tc.frame = 48;
	STAssertEquals((unsigned int)0x00000200, tc.bcd, nil);
	tc.frame = 1439;
	STAssertEquals((unsigned int)0x00005923, tc.bcd, nil);
	tc.frame = 1440;
	STAssertEquals((unsigned int)0x00010000, tc.bcd, nil);
	tc.frame = 2879;
	STAssertEquals((unsigned int)0x00015923, tc.bcd, nil);
	tc.frame = 2880;
	STAssertEquals((unsigned int)0x00020000, tc.bcd, nil);
	tc.frame = 4319;
	STAssertEquals((unsigned int)0x00025923, tc.bcd, nil);
	tc.frame = 4320;
	STAssertEquals((unsigned int)0x00030000, tc.bcd, nil);
	tc.frame = 14399;
	STAssertEquals((unsigned int)0x00095923, tc.bcd, nil);
	tc.frame = 14400;
	STAssertEquals((unsigned int)0x00100000, tc.bcd, nil);
	tc.frame = 14401;
	STAssertEquals((unsigned int)0x00100001, tc.bcd, nil);
	tc.frame = 15839;
	STAssertEquals((unsigned int)0x00105923, tc.bcd, nil);
	tc.frame = 15840;
	STAssertEquals((unsigned int)0x00110000, tc.bcd, nil);
}

- (void)testTC2398SetBcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2398];
	
	tc.bcd = 0x00000000;
	STAssertEquals((long)0, tc.frame, nil);
	tc.bcd = 0x00000001;
	STAssertEquals((long)1, tc.frame, nil);
	tc.bcd = 0x00000023;
	STAssertEquals((long)23, tc.frame, nil);
	tc.bcd = 0x00000100;
	STAssertEquals((long)24, tc.frame, nil);
	tc.bcd = 0x00000123;
	STAssertEquals((long)47, tc.frame, nil);
	tc.bcd = 0x00000200;
	STAssertEquals((long)48, tc.frame, nil);
	tc.bcd = 0x00005923;
	STAssertEquals((long)1439, tc.frame, nil);
	tc.bcd = 0x00010000;
	STAssertEquals((long)1440, tc.frame, nil);
	tc.bcd = 0x00015923;
	STAssertEquals((long)2879, tc.frame, nil);
	tc.bcd = 0x00020000;
	STAssertEquals((long)2880, tc.frame, nil);
	tc.bcd = 0x00025923;
	STAssertEquals((long)4319, tc.frame, nil);
	tc.bcd = 0x00030000;
	STAssertEquals((long)4320, tc.frame, nil);
	tc.bcd = 0x00095923;
	STAssertEquals((long)14399, tc.frame, nil);
	tc.bcd = 0x00100000;
	STAssertEquals((long)14400, tc.frame, nil);
	tc.bcd = 0x00100001;
	STAssertEquals((long)14401, tc.frame, nil);
	tc.bcd = 0x00105923;
	STAssertEquals((long)15839, tc.frame, nil);
	tc.bcd = 0x00110000;
	STAssertEquals((long)15840, tc.frame, nil);
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
	STAssertEquals((long)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((long)1, tc.frame, nil);
	tc.string = @"00:00:00:23";
	STAssertEquals((long)23, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((long)24, tc.frame, nil);
	tc.string = @"00:00:01:23";
	STAssertEquals((long)47, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((long)48, tc.frame, nil);
	tc.string = @"00:00:59:23";
	STAssertEquals((long)1439, tc.frame, nil);
	tc.string = @"00:01:00:00";
	STAssertEquals((long)1440, tc.frame, nil);
	tc.string = @"00:01:59:23";
	STAssertEquals((long)2879, tc.frame, nil);
	tc.string = @"00:02:00:00";
	STAssertEquals((long)2880, tc.frame, nil);
	tc.string = @"00:02:59:23";
	STAssertEquals((long)4319, tc.frame, nil);
	tc.string = @"00:03:00:00";
	STAssertEquals((long)4320, tc.frame, nil);
	tc.string = @"00:09:59:23";
	STAssertEquals((long)14399, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((long)14400, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((long)14401, tc.frame, nil);
	tc.string = @"00:10:59:23";
	STAssertEquals((long)15839, tc.frame, nil);
	tc.string = @"00:11:00:00";
	STAssertEquals((long)15840, tc.frame, nil);
}

- (void)testTC24BcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode24];
	
	STAssertEquals((unsigned int)0x00000000, tc.bcd, nil);
	tc.frame = 1;
	STAssertEquals((unsigned int)0x00000001, tc.bcd, nil);
	tc.frame = 23;
	STAssertEquals((unsigned int)0x00000023, tc.bcd, nil);
	tc.frame = 24;
	STAssertEquals((unsigned int)0x00000100, tc.bcd, nil);
	tc.frame = 47;
	STAssertEquals((unsigned int)0x00000123, tc.bcd, nil);
	tc.frame = 48;
	STAssertEquals((unsigned int)0x00000200, tc.bcd, nil);
	tc.frame = 1439;
	STAssertEquals((unsigned int)0x00005923, tc.bcd, nil);
	tc.frame = 1440;
	STAssertEquals((unsigned int)0x00010000, tc.bcd, nil);
	tc.frame = 2879;
	STAssertEquals((unsigned int)0x00015923, tc.bcd, nil);
	tc.frame = 2880;
	STAssertEquals((unsigned int)0x00020000, tc.bcd, nil);
	tc.frame = 4319;
	STAssertEquals((unsigned int)0x00025923, tc.bcd, nil);
	tc.frame = 4320;
	STAssertEquals((unsigned int)0x00030000, tc.bcd, nil);
	tc.frame = 14399;
	STAssertEquals((unsigned int)0x00095923, tc.bcd, nil);
	tc.frame = 14400;
	STAssertEquals((unsigned int)0x00100000, tc.bcd, nil);
	tc.frame = 14401;
	STAssertEquals((unsigned int)0x00100001, tc.bcd, nil);
	tc.frame = 15839;
	STAssertEquals((unsigned int)0x00105923, tc.bcd, nil);
	tc.frame = 15840;
	STAssertEquals((unsigned int)0x00110000, tc.bcd, nil);
}

- (void)testTC24SetBcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode24];
	
	tc.bcd = 0x00000000;
	STAssertEquals((long)0, tc.frame, nil);
	tc.bcd = 0x00000001;
	STAssertEquals((long)1, tc.frame, nil);
	tc.bcd = 0x00000023;
	STAssertEquals((long)23, tc.frame, nil);
	tc.bcd = 0x00000100;
	STAssertEquals((long)24, tc.frame, nil);
	tc.bcd = 0x00000123;
	STAssertEquals((long)47, tc.frame, nil);
	tc.bcd = 0x00000200;
	STAssertEquals((long)48, tc.frame, nil);
	tc.bcd = 0x00005923;
	STAssertEquals((long)1439, tc.frame, nil);
	tc.bcd = 0x00010000;
	STAssertEquals((long)1440, tc.frame, nil);
	tc.bcd = 0x00015923;
	STAssertEquals((long)2879, tc.frame, nil);
	tc.bcd = 0x00020000;
	STAssertEquals((long)2880, tc.frame, nil);
	tc.bcd = 0x00025923;
	STAssertEquals((long)4319, tc.frame, nil);
	tc.bcd = 0x00030000;
	STAssertEquals((long)4320, tc.frame, nil);
	tc.bcd = 0x00095923;
	STAssertEquals((long)14399, tc.frame, nil);
	tc.bcd = 0x00100000;
	STAssertEquals((long)14400, tc.frame, nil);
	tc.bcd = 0x00100001;
	STAssertEquals((long)14401, tc.frame, nil);
	tc.bcd = 0x00105923;
	STAssertEquals((long)15839, tc.frame, nil);
	tc.bcd = 0x00110000;
	STAssertEquals((long)15840, tc.frame, nil);
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
	STAssertEquals((long)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((long)1, tc.frame, nil);
	tc.string = @"00:00:00:24";
	STAssertEquals((long)24, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((long)25, tc.frame, nil);
	tc.string = @"00:00:01:24";
	STAssertEquals((long)49, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((long)50, tc.frame, nil);
	tc.string = @"00:00:59:24";
	STAssertEquals((long)1499, tc.frame, nil);
	tc.string = @"00:01:00:00";
	STAssertEquals((long)1500, tc.frame, nil);
	tc.string = @"00:01:59:24";
	STAssertEquals((long)2999, tc.frame, nil);
	tc.string = @"00:02:00:00";
	STAssertEquals((long)3000, tc.frame, nil);
	tc.string = @"00:02:59:24";
	STAssertEquals((long)4499, tc.frame, nil);
	tc.string = @"00:03:00:00";
	STAssertEquals((long)4500, tc.frame, nil);
	tc.string = @"00:09:59:24";
	STAssertEquals((long)14999, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((long)15000, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((long)15001, tc.frame, nil);
	tc.string = @"00:10:59:24";
	STAssertEquals((long)16499, tc.frame, nil);
	tc.string = @"00:11:00:00";
	STAssertEquals((long)16500, tc.frame, nil);
}

- (void)testTC25BcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode25];
	
	STAssertEquals((unsigned int)0x00000000, tc.bcd, nil);
	tc.frame = 1;
	STAssertEquals((unsigned int)0x00000001, tc.bcd, nil);
	tc.frame = 24;
	STAssertEquals((unsigned int)0x00000024, tc.bcd, nil);
	tc.frame = 25;
	STAssertEquals((unsigned int)0x00000100, tc.bcd, nil);
	tc.frame = 49;
	STAssertEquals((unsigned int)0x00000124, tc.bcd, nil);
	tc.frame = 50;
	STAssertEquals((unsigned int)0x00000200, tc.bcd, nil);
	tc.frame = 1499;
	STAssertEquals((unsigned int)0x00005924, tc.bcd, nil);
	tc.frame = 1500;
	STAssertEquals((unsigned int)0x00010000, tc.bcd, nil);
	tc.frame = 2999;
	STAssertEquals((unsigned int)0x00015924, tc.bcd, nil);
	tc.frame = 3000;
	STAssertEquals((unsigned int)0x00020000, tc.bcd, nil);
	tc.frame = 4499;
	STAssertEquals((unsigned int)0x00025924, tc.bcd, nil);
	tc.frame = 4500;
	STAssertEquals((unsigned int)0x00030000, tc.bcd, nil);
	tc.frame = 14999;
	STAssertEquals((unsigned int)0x00095924, tc.bcd, nil);
	tc.frame = 15000;
	STAssertEquals((unsigned int)0x00100000, tc.bcd, nil);
	tc.frame = 15001;
	STAssertEquals((unsigned int)0x00100001, tc.bcd, nil);
	tc.frame = 16499;
	STAssertEquals((unsigned int)0x00105924, tc.bcd, nil);
	tc.frame = 16500;
	STAssertEquals((unsigned int)0x00110000, tc.bcd, nil);
}

- (void)testTC25SetBcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode25];
	
	tc.bcd = 0x00000000;
	STAssertEquals((long)0, tc.frame, nil);
	tc.bcd = 0x00000001;
	STAssertEquals((long)1, tc.frame, nil);
	tc.bcd = 0x00000024;
	STAssertEquals((long)24, tc.frame, nil);
	tc.bcd = 0x00000100;
	STAssertEquals((long)25, tc.frame, nil);
	tc.bcd = 0x00000124;
	STAssertEquals((long)49, tc.frame, nil);
	tc.bcd = 0x00000200;
	STAssertEquals((long)50, tc.frame, nil);
	tc.bcd = 0x00005924;
	STAssertEquals((long)1499, tc.frame, nil);
	tc.bcd = 0x00010000;
	STAssertEquals((long)1500, tc.frame, nil);
	tc.bcd = 0x00015924;
	STAssertEquals((long)2999, tc.frame, nil);
	tc.bcd = 0x00020000;
	STAssertEquals((long)3000, tc.frame, nil);
	tc.bcd = 0x00025924;
	STAssertEquals((long)4499, tc.frame, nil);
	tc.bcd = 0x00030000;
	STAssertEquals((long)4500, tc.frame, nil);
	tc.bcd = 0x00095924;
	STAssertEquals((long)14999, tc.frame, nil);
	tc.bcd = 0x00100000;
	STAssertEquals((long)15000, tc.frame, nil);
	tc.bcd = 0x00100001;
	STAssertEquals((long)15001, tc.frame, nil);
	tc.bcd = 0x00105924;
	STAssertEquals((long)16499, tc.frame, nil);
	tc.bcd = 0x00110000;
	STAssertEquals((long)16500, tc.frame, nil);
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
	STAssertEquals((long)0, tc.frame, nil);
	tc.string = @"00:00:00:01";
	STAssertEquals((long)1, tc.frame, nil);
	tc.string = @"00:00:00:29";
	STAssertEquals((long)29, tc.frame, nil);
	tc.string = @"00:00:01:00";
	STAssertEquals((long)30, tc.frame, nil);
	tc.string = @"00:00:01:29";
	STAssertEquals((long)59, tc.frame, nil);
	tc.string = @"00:00:02:00";
	STAssertEquals((long)60, tc.frame, nil);
	tc.string = @"00:00:59:29";
	STAssertEquals((long)1799, tc.frame, nil);
	tc.string = @"00:01:00:02";
	STAssertEquals((long)1800, tc.frame, nil);
	tc.string = @"00:01:59:29";
	STAssertEquals((long)3597, tc.frame, nil);
	tc.string = @"00:02:00:02";
	STAssertEquals((long)3598, tc.frame, nil);
	tc.string = @"00:02:59:29";
	STAssertEquals((long)5395, tc.frame, nil);
	tc.string = @"00:03:00:02";
	STAssertEquals((long)5396, tc.frame, nil);
	tc.string = @"00:03:59:29";
	STAssertEquals((long)7193, tc.frame, nil);
	tc.string = @"00:04:00:02";
	STAssertEquals((long)7194, tc.frame, nil);
	tc.string = @"00:09:59:29";
	STAssertEquals((long)17981, tc.frame, nil);
	tc.string = @"00:10:00:00";
	STAssertEquals((long)17982, tc.frame, nil);
	tc.string = @"00:10:00:01";
	STAssertEquals((long)17983, tc.frame, nil);
	tc.string = @"00:10:59:29";
	STAssertEquals((long)19781, tc.frame, nil);
	tc.string = @"00:11:00:02";
	STAssertEquals((long)19782, tc.frame, nil);
}


- (void)testTC2997BcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2997];
	
	STAssertEquals((unsigned int)0x000000, tc.bcd, nil);
	tc.frame = 1;
	STAssertEquals((unsigned int)0x00000001, tc.bcd, nil);
	tc.frame = 2;
	STAssertEquals((unsigned int)0x00000002, tc.bcd, nil);
	tc.frame = 29;
	STAssertEquals((unsigned int)0x00000029, tc.bcd, nil);
	tc.frame = 30;
	STAssertEquals((unsigned int)0x00000100, tc.bcd, nil);
	tc.frame = 59;
	STAssertEquals((unsigned int)0x00000129, tc.bcd, nil);
	tc.frame = 60;
	STAssertEquals((unsigned int)0x00000200, tc.bcd, nil);
	tc.frame = 1799;
	STAssertEquals((unsigned int)0x00005929, tc.bcd, nil);
	tc.frame = 1800;
	STAssertEquals((unsigned int)0x00010002, tc.bcd, nil);
	tc.frame = 3597;
	STAssertEquals((unsigned int)0x00015929, tc.bcd, nil);
	tc.frame = 3598;
	STAssertEquals((unsigned int)0x00020002, tc.bcd, nil);
	tc.frame = 5395;
	STAssertEquals((unsigned int)0x00025929, tc.bcd, nil);
	tc.frame = 5396;
	STAssertEquals((unsigned int)0x00030002, tc.bcd, nil);
	tc.frame = 7193;
	STAssertEquals((unsigned int)0x00035929, tc.bcd, nil);
	tc.frame = 7194;
	STAssertEquals((unsigned int)0x00040002, tc.bcd, nil);
	tc.frame = 17981;
	STAssertEquals((unsigned int)0x00095929, tc.bcd, nil);
	tc.frame = 17982;
	STAssertEquals((unsigned int)0x00100000, tc.bcd, nil);
	tc.frame = 17983;
	STAssertEquals((unsigned int)0x00100001, tc.bcd, nil);
	tc.frame = 19781;
	STAssertEquals((unsigned int)0x00105929, tc.bcd, nil);
	tc.frame = 19782;
	STAssertEquals((unsigned int)0x00110002, tc.bcd, nil);
}

- (void)testTC2997SetBcdTest01
{
	DWTimeCode * tc =[[DWTimeCode alloc] initWithType:kDWTimeCode2997];
	
	tc.bcd = 0x00000000;
	STAssertEquals((long)0, tc.frame, nil);
	tc.bcd = 0x00000001;
	STAssertEquals((long)1, tc.frame, nil);
	tc.bcd = 0x00000029;
	STAssertEquals((long)29, tc.frame, nil);
	tc.bcd = 0x00000100;
	STAssertEquals((long)30, tc.frame, nil);
	tc.bcd = 0x00000129;
	STAssertEquals((long)59, tc.frame, nil);
	tc.bcd = 0x00000200;
	STAssertEquals((long)60, tc.frame, nil);
	tc.bcd = 0x00005929;
	STAssertEquals((long)1799, tc.frame, nil);
	tc.bcd = 0x00010002;
	STAssertEquals((long)1800, tc.frame, nil);
	tc.bcd = 0x00015929;
	STAssertEquals((long)3597, tc.frame, nil);
	tc.bcd = 0x00020002;
	STAssertEquals((long)3598, tc.frame, nil);
	tc.bcd = 0x00025929;
	STAssertEquals((long)5395, tc.frame, nil);
	tc.bcd = 0x00030002;
	STAssertEquals((long)5396, tc.frame, nil);
	tc.bcd = 0x00035929;
	STAssertEquals((long)7193, tc.frame, nil);
	tc.bcd = 0x00040002;
	STAssertEquals((long)7194, tc.frame, nil);
	tc.bcd = 0x00095929;
	STAssertEquals((long)17981, tc.frame, nil);
	tc.bcd = 0x00100000;
	STAssertEquals((long)17982, tc.frame, nil);
	tc.bcd = 0x00100001;
	STAssertEquals((long)17983, tc.frame, nil);
	tc.bcd = 0x00105929;
	STAssertEquals((long)19781, tc.frame, nil);
	tc.bcd = 0x00110002;
	STAssertEquals((long)19782, tc.frame, nil);
}

@end
