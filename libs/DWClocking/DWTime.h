//
//  DWTime.h
//  DWClocking
//
//  Created by Martin Delille on 14/04/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 Amount of time unit per second.
 */
#define DWTIMESCALE 192000

/**  
 Duration of a 23.98 timecode frame
 */
#define DWTC2398FRAMEDURATION 8008

/**  
 Duration of a 24 timecode frame
 */
#define DWTC24FRAMEDURATION 8000

/**  
 Duration of a 25 timecode frame
 */
#define DWTC25FRAMEDURATION 7680

/**  
 Duration of a 29.97 timecode frame
 */
#define DWTC2997FRAMEDURATION 6408

/** 
 Amount of time unit (according to the DWTIMESCALE) since the origin.
 */
typedef long DWTime;

