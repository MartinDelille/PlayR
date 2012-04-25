//
//  DWToolsTests.m
//  DWToolsTests
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWToolsTests.h"
#import "DWBCDTool.h"

@implementation DWToolsTests

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

-(void)testBcdFromUInteger01 {
	STAssertEquals((unsigned int)0x00000000, [DWBCDTool bcdFromUInt:0], nil);
	STAssertEquals((unsigned int)0x00000001, [DWBCDTool bcdFromUInt:1], nil);
	STAssertEquals((unsigned int)0x00000009, [DWBCDTool bcdFromUInt:9], nil);
	STAssertEquals((unsigned int)0x00000010, [DWBCDTool bcdFromUInt:10], nil);
	STAssertEquals((unsigned int)0x00000011, [DWBCDTool bcdFromUInt:11], nil);
	STAssertEquals((unsigned int)0x00000019, [DWBCDTool bcdFromUInt:19], nil);
	STAssertEquals((unsigned int)0x00000020, [DWBCDTool bcdFromUInt:20], nil);
	STAssertEquals((unsigned int)0x00000099, [DWBCDTool bcdFromUInt:99], nil);
	STAssertEquals((unsigned int)0x00000100, [DWBCDTool bcdFromUInt:100], nil);
	STAssertEquals((unsigned int)0x00000199, [DWBCDTool bcdFromUInt:199], nil);
	STAssertEquals((unsigned int)0x00000200, [DWBCDTool bcdFromUInt:200], nil);
	STAssertEquals((unsigned int)0x00001234, [DWBCDTool bcdFromUInt:1234], nil);
	STAssertEquals((unsigned int)0x00012345, [DWBCDTool bcdFromUInt:12345], nil);
	STAssertEquals((unsigned int)0x00123456, [DWBCDTool bcdFromUInt:123456], nil);
	STAssertEquals((unsigned int)0x01234567, [DWBCDTool bcdFromUInt:1234567], nil);
	STAssertEquals((unsigned int)0x12345678, [DWBCDTool bcdFromUInt:12345678], nil);
}

-(void)testUIntegerFromBcd01 {
	STAssertEquals((unsigned int)0, [DWBCDTool uintFromBcd:0x00000000], nil);
	STAssertEquals((unsigned int)1, [DWBCDTool uintFromBcd:0x00000001], nil);
	STAssertEquals((unsigned int)9, [DWBCDTool uintFromBcd:0x00000009], nil);
	STAssertEquals((unsigned int)10, [DWBCDTool uintFromBcd:0x00000010], nil);
	STAssertEquals((unsigned int)11, [DWBCDTool uintFromBcd:0x00000011], nil);
	STAssertEquals((unsigned int)19, [DWBCDTool uintFromBcd:0x00000019], nil);
	STAssertEquals((unsigned int)20, [DWBCDTool uintFromBcd:0x00000020], nil);
	STAssertEquals((unsigned int)99, [DWBCDTool uintFromBcd:0x00000099], nil);
	STAssertEquals((unsigned int)100, [DWBCDTool uintFromBcd:0x00000100], nil);
	STAssertEquals((unsigned int)199, [DWBCDTool uintFromBcd:0x00000199], nil);
	STAssertEquals((unsigned int)200, [DWBCDTool uintFromBcd:0x00000200], nil);
	STAssertEquals((unsigned int)1234, [DWBCDTool uintFromBcd:0x00001234], nil);
	STAssertEquals((unsigned int)12345, [DWBCDTool uintFromBcd:0x00012345], nil);
	STAssertEquals((unsigned int)123456, [DWBCDTool uintFromBcd:0x00123456], nil);
	STAssertEquals((unsigned int)1234567, [DWBCDTool uintFromBcd:0x01234567], nil);
	STAssertEquals((unsigned int)12345678, [DWBCDTool uintFromBcd:0x12345678], nil);	
}

@end
