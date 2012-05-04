//
//  DWDocument.h
//  DWVideoTest01
//
//  Created by Martin Delille on 03/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>
#import "DWVideo/DWVideoClock.h"

@interface DWDocument : NSDocument{
	DWVideoClock * _clock;
	QTMovie * _movie;
	NSTextField * _txtCurrentTC;
}


@property(retain) IBOutlet NSTextField *txtCurrentTC;

@property(retain) QTMovie * movie;
@property(retain) DWVideoClock * clock;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)fastForward:(id)sender;
- (IBAction)reverse:(id)sender;
- (IBAction)rewind:(id)sender;

@end
