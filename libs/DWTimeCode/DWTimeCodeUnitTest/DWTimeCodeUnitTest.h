//
//  DWTimeCodeUnitTest.h
//  DWTimeCodeUnitTest
//
//  Created by Martin Delille on 21/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

/** Unit test for DWTimeCode
 
 Test all the method of DWTimeCode
 */
@interface DWTimeCodeUnitTest : SenTestCase

/** 
 Test the string getter for 23.98 timecode.
 */
-(void)testTC2398StringTest01;

/** 
 Test the setString setter for 23.98 timecode.
 */
-(void)testTC2398SetStringTest01;

/** 
 Test the bcd getter for 23.98 timecode.
 */
-(void)testTC2398BcdTest01;

/** 
 Test the setBcd setter for 23.98 timecode.
 */
-(void)testTC2398SetBcdTest01;

/** 
 Test the string getter for 24 timecode.
 */
-(void)testTC24StringTest01;

/** 
 Test the setString setter for 24 timecode.
 */
-(void)testTC24SetStringTest01;

/** 
 Test the bcd getter for 24 timecode.
 */
-(void)testTC24BcdTest01;

/** 
 Test the setBcd setter for 24 timecode.
 */
-(void)testTC24SetBcdTest01;

/** 
 Test the string getter for 25 timecode.
 */
-(void)testTC25StringTest01;

/** 
 Test the setString setter for 25 timecode.
 */
-(void)testTC25SetStringTest01;

/** 
 Test the bcd getter for 25 timecode.
 */
-(void)testTC25BcdTest01;

/** 
 Test the setBcd setter for 25 timecode.
 */
-(void)testTC25SetBcdTest01;

/** 
 Test the string getter for 29.97 timecode.
 */
-(void)testTC2997StringTest01;

/** 
 Test the setString setter for 29.97 timecode.
 */
-(void)testTC2997SetStringTest01;

/** 
 Test the bcd getter for 29.97 timecode.
 */
-(void)testTC2997BcdTest01;

/** 
 Test the setBcd setter for 29.97 timecode.
 */
-(void)testTC2997SetBcdTest01;

@end
