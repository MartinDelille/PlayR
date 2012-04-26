//
//  DWClockingUnitTests.m
//  DWClockingUnitTests
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClockingUnitTests.h"
#import "DWTimeCode.h"

@implementation DWClockingUnitTests

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

-(void)testStringFromFrameForTC2398 {
	DWTimeCodeType type = kDWTimeCode2398;

	DWFrame frame = 0;
	STAssertEqualObjects(@"00:00:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEqualObjects(@"00:00:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 23;
	STAssertEqualObjects(@"00:00:00:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 24;
	STAssertEqualObjects(@"00:00:01:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 47;
	STAssertEqualObjects(@"00:00:01:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 48;
	STAssertEqualObjects(@"00:00:02:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1439;
	STAssertEqualObjects(@"00:00:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1440;
	STAssertEqualObjects(@"00:01:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 2879;
	STAssertEqualObjects(@"00:01:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 2880;
	STAssertEqualObjects(@"00:02:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 4319;
	STAssertEqualObjects(@"00:02:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 4320;
	STAssertEqualObjects(@"00:03:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14399;
	STAssertEqualObjects(@"00:09:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14400;
	STAssertEqualObjects(@"00:10:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14401;
	STAssertEqualObjects(@"00:10:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 15839;
	STAssertEqualObjects(@"00:10:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 15840;
	STAssertEqualObjects(@"00:11:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
}

-(void)testStringFromFrameForTC24 {
	DWTimeCodeType type = kDWTimeCode24;
	
	DWFrame frame = 0;
	STAssertEqualObjects(@"00:00:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEqualObjects(@"00:00:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 23;
	STAssertEqualObjects(@"00:00:00:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 24;
	STAssertEqualObjects(@"00:00:01:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 47;
	STAssertEqualObjects(@"00:00:01:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 48;
	STAssertEqualObjects(@"00:00:02:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1439;
	STAssertEqualObjects(@"00:00:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1440;
	STAssertEqualObjects(@"00:01:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 2879;
	STAssertEqualObjects(@"00:01:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 2880;
	STAssertEqualObjects(@"00:02:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 4319;
	STAssertEqualObjects(@"00:02:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 4320;
	STAssertEqualObjects(@"00:03:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14399;
	STAssertEqualObjects(@"00:09:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14400;
	STAssertEqualObjects(@"00:10:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14401;
	STAssertEqualObjects(@"00:10:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 15839;
	STAssertEqualObjects(@"00:10:59:23", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 15840;
	STAssertEqualObjects(@"00:11:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
}

-(void)testStringFromFrameForTC25 {
	DWTimeCodeType type = kDWTimeCode25;
	DWFrame frame = 0;
	STAssertEqualObjects(@"00:00:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	
	frame = 1;
	STAssertEqualObjects(@"00:00:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 24;
	STAssertEqualObjects(@"00:00:00:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 25;
	STAssertEqualObjects(@"00:00:01:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 49;
	STAssertEqualObjects(@"00:00:01:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 50;
	STAssertEqualObjects(@"00:00:02:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1499;
	STAssertEqualObjects(@"00:00:59:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1500;
	STAssertEqualObjects(@"00:01:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 2999;
	STAssertEqualObjects(@"00:01:59:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 3000;
	STAssertEqualObjects(@"00:02:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 4499;
	STAssertEqualObjects(@"00:02:59:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 4500;
	STAssertEqualObjects(@"00:03:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 14999;
	STAssertEqualObjects(@"00:09:59:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 15000;
	STAssertEqualObjects(@"00:10:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 15001;
	STAssertEqualObjects(@"00:10:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 16499;
	STAssertEqualObjects(@"00:10:59:24", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 16500;
	STAssertEqualObjects(@"00:11:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
}

-(void)testStringFromFrameForTC2997 {
	DWTimeCodeType type = kDWTimeCode2997;
	DWFrame frame = 0;	
	STAssertEqualObjects(@"00:00:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEqualObjects(@"00:00:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 2;
	STAssertEqualObjects(@"00:00:00:02", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 29;
	STAssertEqualObjects(@"00:00:00:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 30;
	STAssertEqualObjects(@"00:00:01:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 59;
	STAssertEqualObjects(@"00:00:01:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 60;
	STAssertEqualObjects(@"00:00:02:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1799;
	STAssertEqualObjects(@"00:00:59:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 1800;
	STAssertEqualObjects(@"00:01:00:02", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 3597;
	STAssertEqualObjects(@"00:01:59:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 3598;
	STAssertEqualObjects(@"00:02:00:02", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 5395;
	STAssertEqualObjects(@"00:02:59:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 5396;
	STAssertEqualObjects(@"00:03:00:02", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 7193;
	STAssertEqualObjects(@"00:03:59:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 7194;
	STAssertEqualObjects(@"00:04:00:02", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 17981;
	STAssertEqualObjects(@"00:09:59:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 17982;
	STAssertEqualObjects(@"00:10:00:00", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 17983;
	STAssertEqualObjects(@"00:10:00:01", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 19781;
	STAssertEqualObjects(@"00:10:59:29", [DWTimeCode stringFromFrame:frame andType:type], nil);
	frame = 19782;
	STAssertEqualObjects(@"00:11:00:02", [DWTimeCode stringFromFrame:frame andType:type], nil);
}

-(void)testFrameFromStringForTC2398 {
	DWTimeCodeType type = kDWTimeCode2398;
	NSString * string = @"00:00:00:00";
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:01";
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:23";
	STAssertEquals((DWFrame)23, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:00";
	STAssertEquals((DWFrame)24, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:23";
	STAssertEquals((DWFrame)47, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:02:00";
	STAssertEquals((DWFrame)48, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:59:23";
	STAssertEquals((DWFrame)1439, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:00:00";
	STAssertEquals((DWFrame)1440, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:59:23";
	STAssertEquals((DWFrame)2879, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:00:00";
	STAssertEquals((DWFrame)2880, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:59:23";
	STAssertEquals((DWFrame)4319, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:03:00:00";
	STAssertEquals((DWFrame)4320, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:09:59:23";
	STAssertEquals((DWFrame)14399, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:00";
	STAssertEquals((DWFrame)14400, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:01";
	STAssertEquals((DWFrame)14401, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:59:23";
	STAssertEquals((DWFrame)15839, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:11:00:00";
	STAssertEquals((DWFrame)15840, [DWTimeCode frameFromString:string andType:type], nil);

}

-(void)testFrameFromStringForTC24 {
	DWTimeCodeType type = kDWTimeCode24;
	NSString * string = @"00:00:00:00";
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:01";
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:23";
	STAssertEquals((DWFrame)23, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:00";
	STAssertEquals((DWFrame)24, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:23";
	STAssertEquals((DWFrame)47, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:02:00";
	STAssertEquals((DWFrame)48, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:59:23";
	STAssertEquals((DWFrame)1439, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:00:00";
	STAssertEquals((DWFrame)1440, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:59:23";
	STAssertEquals((DWFrame)2879, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:00:00";
	STAssertEquals((DWFrame)2880, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:59:23";
	STAssertEquals((DWFrame)4319, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:03:00:00";
	STAssertEquals((DWFrame)4320, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:09:59:23";
	STAssertEquals((DWFrame)14399, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:00";
	STAssertEquals((DWFrame)14400, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:01";
	STAssertEquals((DWFrame)14401, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:59:23";
	STAssertEquals((DWFrame)15839, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:11:00:00";
	
}

-(void)testFrameFromStringForTC25 {
	DWTimeCodeType type = kDWTimeCode25;
	NSString * string = @"00:00:00:00";
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:01";
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:24";
	STAssertEquals((DWFrame)24, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:00";
	STAssertEquals((DWFrame)25, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:24";
	STAssertEquals((DWFrame)49, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:02:00";
	STAssertEquals((DWFrame)50, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:59:24";
	STAssertEquals((DWFrame)1499, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:00:00";
	STAssertEquals((DWFrame)1500, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:59:24";
	STAssertEquals((DWFrame)2999, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:00:00";
	STAssertEquals((DWFrame)3000, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:59:24";
	STAssertEquals((DWFrame)4499, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:03:00:00";
	STAssertEquals((DWFrame)4500, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:09:59:24";
	STAssertEquals((DWFrame)14999, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:00";
	STAssertEquals((DWFrame)15000, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:01";
	STAssertEquals((DWFrame)15001, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:59:24";
	STAssertEquals((DWFrame)16499, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:11:00:00";
	STAssertEquals((DWFrame)16500, [DWTimeCode frameFromString:string andType:type], nil);
}

-(void)testFrameFromStringForTC2997 {
	DWTimeCodeType type = kDWTimeCode2997;
	NSString * string = @"00:00:00:00";
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:01";
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:00:29";
	STAssertEquals((DWFrame)29, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:00";
	STAssertEquals((DWFrame)30, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:01:29";
	STAssertEquals((DWFrame)59, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:02:00";
	STAssertEquals((DWFrame)60, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:00:59:29";
	STAssertEquals((DWFrame)1799, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:00:02";
	STAssertEquals((DWFrame)1800, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:01:59:29";
	STAssertEquals((DWFrame)3597, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:00:02";
	STAssertEquals((DWFrame)3598, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:02:59:29";
	STAssertEquals((DWFrame)5395, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:03:00:02";
	STAssertEquals((DWFrame)5396, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:03:59:29";
	STAssertEquals((DWFrame)7193, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:04:00:02";
	STAssertEquals((DWFrame)7194, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:09:59:29";
	STAssertEquals((DWFrame)17981, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:00";
	STAssertEquals((DWFrame)17982, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:00:01";
	STAssertEquals((DWFrame)17983, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:10:59:29";
	STAssertEquals((DWFrame)19781, [DWTimeCode frameFromString:string andType:type], nil);
	string = @"00:11:00:02";
	STAssertEquals((DWFrame)19782, [DWTimeCode frameFromString:string andType:type], nil);
}

-(void)testBcdFromFrameForTC2398 {
	DWTimeCodeType type = kDWTimeCode2398;
	DWFrame frame = 0;
	
	STAssertEquals((unsigned int)0x00000000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEquals((unsigned int)0x00000001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 23;
	STAssertEquals((unsigned int)0x00000023, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 24;
	STAssertEquals((unsigned int)0x00000100, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 47;
	STAssertEquals((unsigned int)0x00000123, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 48;
	STAssertEquals((unsigned int)0x00000200, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1439;
	STAssertEquals((unsigned int)0x00005923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1440;
	STAssertEquals((unsigned int)0x00010000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 2879;
	STAssertEquals((unsigned int)0x00015923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 2880;
	STAssertEquals((unsigned int)0x00020000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 4319;
	STAssertEquals((unsigned int)0x00025923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 4320;
	STAssertEquals((unsigned int)0x00030000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14399;
	STAssertEquals((unsigned int)0x00095923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14400;
	STAssertEquals((unsigned int)0x00100000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14401;
	STAssertEquals((unsigned int)0x00100001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 15839;
	STAssertEquals((unsigned int)0x00105923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 15840;
	STAssertEquals((unsigned int)0x00110000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
}

-(void)testBcdFromFrameForTC24 {
	DWTimeCodeType type = kDWTimeCode24;
	DWFrame frame = 0;
	
	STAssertEquals((unsigned int)0x00000000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEquals((unsigned int)0x00000001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 23;
	STAssertEquals((unsigned int)0x00000023, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 24;
	STAssertEquals((unsigned int)0x00000100, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 47;
	STAssertEquals((unsigned int)0x00000123, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 48;
	STAssertEquals((unsigned int)0x00000200, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1439;
	STAssertEquals((unsigned int)0x00005923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1440;
	STAssertEquals((unsigned int)0x00010000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 2879;
	STAssertEquals((unsigned int)0x00015923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 2880;
	STAssertEquals((unsigned int)0x00020000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 4319;
	STAssertEquals((unsigned int)0x00025923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 4320;
	STAssertEquals((unsigned int)0x00030000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14399;
	STAssertEquals((unsigned int)0x00095923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14400;
	STAssertEquals((unsigned int)0x00100000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14401;
	STAssertEquals((unsigned int)0x00100001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 15839;
	STAssertEquals((unsigned int)0x00105923, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 15840;
	STAssertEquals((unsigned int)0x00110000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
}

-(void)testBcdFromFrameForTC25 {
	DWTimeCodeType type = kDWTimeCode25;
	DWFrame frame = 0;
	
	STAssertEquals((unsigned int)0x00000000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEquals((unsigned int)0x00000001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 24;
	STAssertEquals((unsigned int)0x00000024, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 25;
	STAssertEquals((unsigned int)0x00000100, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 49;
	STAssertEquals((unsigned int)0x00000124, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 50;
	STAssertEquals((unsigned int)0x00000200, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1499;
	STAssertEquals((unsigned int)0x00005924, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1500;
	STAssertEquals((unsigned int)0x00010000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 2999;
	STAssertEquals((unsigned int)0x00015924, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 3000;
	STAssertEquals((unsigned int)0x00020000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 4499;
	STAssertEquals((unsigned int)0x00025924, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 4500;
	STAssertEquals((unsigned int)0x00030000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 14999;
	STAssertEquals((unsigned int)0x00095924, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 15000;
	STAssertEquals((unsigned int)0x00100000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 15001;
	STAssertEquals((unsigned int)0x00100001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 16499;
	STAssertEquals((unsigned int)0x00105924, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 16500;
	STAssertEquals((unsigned int)0x00110000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
}

-(void)testBcdFromFrameForTC2997 {
	DWTimeCodeType type = kDWTimeCode2997;
	DWFrame frame = 0;
	
	STAssertEquals((unsigned int)0x000000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1;
	STAssertEquals((unsigned int)0x00000001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 2;
	STAssertEquals((unsigned int)0x00000002, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 29;
	STAssertEquals((unsigned int)0x00000029, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 30;
	STAssertEquals((unsigned int)0x00000100, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 59;
	STAssertEquals((unsigned int)0x00000129, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 60;
	STAssertEquals((unsigned int)0x00000200, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1799;
	STAssertEquals((unsigned int)0x00005929, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 1800;
	STAssertEquals((unsigned int)0x00010002, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 3597;
	STAssertEquals((unsigned int)0x00015929, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 3598;
	STAssertEquals((unsigned int)0x00020002, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 5395;
	STAssertEquals((unsigned int)0x00025929, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 5396;
	STAssertEquals((unsigned int)0x00030002, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 7193;
	STAssertEquals((unsigned int)0x00035929, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 7194;
	STAssertEquals((unsigned int)0x00040002, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 17981;
	STAssertEquals((unsigned int)0x00095929, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 17982;
	STAssertEquals((unsigned int)0x00100000, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 17983;
	STAssertEquals((unsigned int)0x00100001, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 19781;
	STAssertEquals((unsigned int)0x00105929, [DWTimeCode bcdFromFrame:frame andType:type], nil);
	frame = 19782;
	STAssertEquals((unsigned int)0x00110002, [DWTimeCode bcdFromFrame:frame andType:type], nil);
}

-(void)testFrameFromBcdForTC2398 {
	DWTimeCodeType type = kDWTimeCode2398;
	unsigned int bcd = 0x00000000;
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000001;
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000023;
	STAssertEquals((DWFrame)23, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000100;
	STAssertEquals((DWFrame)24, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000123;
	STAssertEquals((DWFrame)47, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000200;
	STAssertEquals((DWFrame)48, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00005923;
	STAssertEquals((DWFrame)1439, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00010000;
	STAssertEquals((DWFrame)1440, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00015923;
	STAssertEquals((DWFrame)2879, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00020000;
	STAssertEquals((DWFrame)2880, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00025923;
	STAssertEquals((DWFrame)4319, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00030000;
	STAssertEquals((DWFrame)4320, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00095923;
	STAssertEquals((DWFrame)14399, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100000;
	STAssertEquals((DWFrame)14400, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100001;
	STAssertEquals((DWFrame)14401, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00105923;
	STAssertEquals((DWFrame)15839, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00110000;
	STAssertEquals((DWFrame)15840, [DWTimeCode frameFromBcd:bcd andType:type], nil);
}

-(void)testFrameFromBcdForTC24 {
	DWTimeCodeType type = kDWTimeCode24;
	unsigned int bcd = 0x00000000;
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000001;
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000023;
	STAssertEquals((DWFrame)23, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000100;
	STAssertEquals((DWFrame)24, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000123;
	STAssertEquals((DWFrame)47, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000200;
	STAssertEquals((DWFrame)48, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00005923;
	STAssertEquals((DWFrame)1439, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00010000;
	STAssertEquals((DWFrame)1440, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00015923;
	STAssertEquals((DWFrame)2879, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00020000;
	STAssertEquals((DWFrame)2880, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00025923;
	STAssertEquals((DWFrame)4319, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00030000;
	STAssertEquals((DWFrame)4320, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00095923;
	STAssertEquals((DWFrame)14399, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100000;
	STAssertEquals((DWFrame)14400, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100001;
	STAssertEquals((DWFrame)14401, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00105923;
	STAssertEquals((DWFrame)15839, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00110000;
	STAssertEquals((DWFrame)15840, [DWTimeCode frameFromBcd:bcd andType:type], nil);
}

-(void)testFrameFromBcdForTC25 {
	DWTimeCodeType type = kDWTimeCode25;
	
	unsigned int bcd = 0x00000000;
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000001;
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000024;
	STAssertEquals((DWFrame)24, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000100;
	STAssertEquals((DWFrame)25, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000124;
	STAssertEquals((DWFrame)49, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000200;
	STAssertEquals((DWFrame)50, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00005924;
	STAssertEquals((DWFrame)1499, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00010000;
	STAssertEquals((DWFrame)1500, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00015924;
	STAssertEquals((DWFrame)2999, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00020000;
	STAssertEquals((DWFrame)3000, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00025924;
	STAssertEquals((DWFrame)4499, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00030000;
	STAssertEquals((DWFrame)4500, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00095924;
	STAssertEquals((DWFrame)14999, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100000;
	STAssertEquals((DWFrame)15000, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100001;
	STAssertEquals((DWFrame)15001, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00105924;
	STAssertEquals((DWFrame)16499, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00110000;
	STAssertEquals((DWFrame)16500, [DWTimeCode frameFromBcd:bcd andType:type], nil);
}

-(void)testFrameFromBcdForTC2997 {
	DWTimeCodeType type = kDWTimeCode2997;
	
	unsigned int bcd = 0x00000000;
	STAssertEquals((DWFrame)0, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000001;
	STAssertEquals((DWFrame)1, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000029;
	STAssertEquals((DWFrame)29, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000100;
	STAssertEquals((DWFrame)30, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000129;
	STAssertEquals((DWFrame)59, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00000200;
	STAssertEquals((DWFrame)60, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00005929;
	STAssertEquals((DWFrame)1799, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00010002;
	STAssertEquals((DWFrame)1800, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00015929;
	STAssertEquals((DWFrame)3597, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00020002;
	STAssertEquals((DWFrame)3598, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00025929;
	STAssertEquals((DWFrame)5395, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00030002;
	STAssertEquals((DWFrame)5396, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00035929;
	STAssertEquals((DWFrame)7193, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00040002;
	STAssertEquals((DWFrame)7194, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00095929;
	STAssertEquals((DWFrame)17981, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100000;
	STAssertEquals((DWFrame)17982, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00100001;
	STAssertEquals((DWFrame)17983, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00105929;
	STAssertEquals((DWFrame)19781, [DWTimeCode frameFromBcd:bcd andType:type], nil);
	bcd = 0x00110002;
	STAssertEquals((DWFrame)19782, [DWTimeCode frameFromBcd:bcd andType:type], nil);

}


-(void)testStringFromFrameWithExtremeValue {
	DWTimeCodeType type = kDWTimeCode25;

	STAssertEqualObjects(@"23:59:59:24", [DWTimeCode stringFromFrame:2159999 andType:type], nil);
	STAssertEqualObjects(@"24:00:00:00", [DWTimeCode stringFromFrame:2160000 andType:type], nil);
	STAssertEqualObjects(@"24:00:00:01", [DWTimeCode stringFromFrame:2160001 andType:type], nil);
	STAssertEqualObjects(@"24:10:59:24", [DWTimeCode stringFromFrame:2176499 andType:type], nil);
	
	STAssertEqualObjects(@"-00:00:00:01", [DWTimeCode stringFromFrame:-1 andType:type], nil);
	STAssertEqualObjects(@"-23:59:59:24", [DWTimeCode stringFromFrame:-2159999 andType:type], nil);
	STAssertEqualObjects(@"-24:00:00:00", [DWTimeCode stringFromFrame:-2160000 andType:type], nil);
	STAssertEqualObjects(@"-24:00:00:01", [DWTimeCode stringFromFrame:-2160001 andType:type], nil);
	STAssertEqualObjects(@"-24:10:59:24", [DWTimeCode stringFromFrame:-2176499 andType:type], nil);
}


-(void)testTCWithSpecialString {
	DWTimeCodeType type = kDWTimeCode25;
	
	// bad value for hh, mm, ss and ff
	STAssertEqualObjects(@"12:23:34:00", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:23:34:30" andType:type] andType:type], nil);
	STAssertEqualObjects(@"12:23:34:00", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:23:34:ff" andType:type] andType:type], nil);
	STAssertEqualObjects(@"12:23:00:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:23:60:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"12:23:00:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:23:ss:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"12:00:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:60:34:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"12:00:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:mm:34:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"00:23:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"hh:23:34:19" andType:type] andType:type], nil);
	
	// extreme value for hh
	STAssertEqualObjects(@"24:23:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"24:23:34:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"-01:23:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"-1:23:34:19" andType:type] andType:type], nil);

	// bad digit count
	STAssertEqualObjects(@"00:00:00:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"00:00:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"34:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"00:23:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"23:34:19" andType:type] andType:type], nil);
	STAssertEqualObjects(@"12:23:34:19", [DWTimeCode stringFromFrame:[DWTimeCode frameFromString:@"12:23:34:19:12" andType:type] andType:type], nil);
}

@end
