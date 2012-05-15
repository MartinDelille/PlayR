//
//  DWBoolEventHandler.h
//  DWTools
//
//  Created by Martin Delille on 15/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

/** A bool event handler
 
 Protocol handling a message with a boolean as parameter.
 */
@protocol DWBoolEventHandler <NSObject>

/** 
 A message
 @param b A boolean value
 */
-(void)boolEvent:(BOOL)b;

@end
