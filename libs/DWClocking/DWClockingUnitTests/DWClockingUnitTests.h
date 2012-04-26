//
//  DWClockingUnitTests.h
//  DWClockingUnitTests
//
//  Created by Martin Delille on 24/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface DWClockingUnitTests : SenTestCase

/** 
 Test stringFromFrame for 23.98 timecode.
 */
-(void)testStringFromFrameForTC2398;

/** 
 Test stringFromFrame for 24 timecode.
 */
-(void)testStringFromFrameForTC24;

/** 
 Test stringFromFrame for 25 timecode.
 */
-(void)testStringFromFrameForTC25;

/** 
 Test stringFromFrame for 29.97 timecode.
 */
-(void)testStringFromFrameForTC2997;

/** 
 Test frameFromString for 23.98 timecode.
 */
-(void)testFrameFromStringForTC2398;

/** 
 Test frameFromString for 24 timecode.
 */
-(void)testFrameFromStringForTC24;

/** 
 Test frameFromString for 25 timecode.
 */
-(void)testFrameFromStringForTC25;

/** 
 Test frameFromString for 29.97 timecode.
 */
-(void)testFrameFromStringForTC2997;

/** 
 Test bcdFromFrame for 23.98 timecode.
 */
-(void)testBcdFromFrameForTC2398;

/** 
 Test bcdFromFrame for 24 timecode.
 */
-(void)testBcdFromFrameForTC24;

/** 
 Test bcdFromFrame for 25 timecode.
 */
-(void)testBcdFromFrameForTC25;

/** 
 Test bcdFromFrame for 29.97 timecode.
 */
-(void)testBcdFromFrameForTC2997;

/** 
 Test frameFromBcd for 23.98 timecode.
 */
-(void)testFrameFromBcdForTC2398;

/** 
 Test frameFromBcd for 24 timecode.
 */
-(void)testFrameFromBcdForTC24;

/** 
 Test frameFromBcd for 25 timecode.
 */
-(void)testFrameFromBcdForTC25;

/** 
 Test frameFromBcd for 29.97 timecode.
 */
-(void)testFrameFromBcdForTC2997;

@end
