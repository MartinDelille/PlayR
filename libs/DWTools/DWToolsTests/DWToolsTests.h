//
//  DWToolsTests.h
//  DWToolsTests
//
//  Created by Martin Delille on 23/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

/** Unit test for DWTools project class
 
 Provides unit test for DWBCDTool.
 */
@interface DWToolsTests : SenTestCase

/** 
 Test [DWBCDTool bcdFromUInteger] 
 */
-(void)testBcdFromUInteger01;

/** 
 Test [DWBCDTool uintFromBCD] 
 */
-(void)testUIntegerFromBcd01;

@end
