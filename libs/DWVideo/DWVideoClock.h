//
//  DWVideoClock.h
//  DWVideo
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWClocking/DWClock.h"
#import <QTKit/QTKit.h>

@interface DWVideoClock : DWClock {
	QTMovie* movie;
	DWTime _videoStartTime;
}

@property(readonly) DWTime videoStartTime;

-(id)initWithMovie:(QTMovie*)aMovie;

@end
