//
//  AMStandardEnumerator.h
//
//  Created by Andreas on Mon Aug 04 2003.
//  Copyright (c) 2003 Andreas Mayer. All rights reserved.
//
//  2007-10-26 Sean McBride
//  - made code 64 bit and garbage collection clean

#import "AMSDKCompatibility.h"

#import <Foundation/Foundation.h>

typedef NSUInteger (*CountMethod)(id, SEL);
typedef id (*NextObjectMethod)(id, SEL, NSUInteger);

/**
 Implement a standard enumerator behaviour
 */
@interface AMStandardEnumerator : NSEnumerator
{
@private
	id collection;
	SEL countSelector;
	SEL nextObjectSelector;
	CountMethod count;
	NextObjectMethod nextObject;
	NSUInteger position;
}

/** 
 Designated initializer
 @param theCollection An existing collection
 @param theCountSelector A selector returning the collection element count.
 @param theObjectSelector A selector returning an object at a specified index.
 @return An initialized AMStandardEnumerator object.
 */
- (id)initWithCollection:(id)theCollection countSelector:(SEL)theCountSelector objectAtIndexSelector:(SEL)theObjectSelector;


@end
