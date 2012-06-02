//
//  DWString.h
//  DWTools
//
//  Created by Martin Delille on 02/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWString : NSObject

+(NSString*) stringWithBuffer:(const unsigned char*)buffer andLength:(int)length;

@end
