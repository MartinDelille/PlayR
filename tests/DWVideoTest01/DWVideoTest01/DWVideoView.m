//
//  DWVideoView.m
//  DWVideoTest01
//
//  Created by Martin Delille on 05/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideoView.h"
#import "DWDocument.h"

@implementation DWVideoView {
	AVPlayerLayer * playerLayer;
}

@synthesize doc;

-(AVPlayer *)player {
	return [playerLayer player];
}

-(void)setPlayer:(AVPlayer *)player {
	self.wantsLayer = YES;
	playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
	playerLayer.frame = self.bounds;
	playerLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
	playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.layer addSublayer:playerLayer];
}

-(BOOL)acceptsFirstResponder {
	return YES;
}

-(void)keyDown:(NSEvent *)theEvent {
	DWLog(@"keyCode: %X", theEvent.keyCode);
	switch (theEvent.keyCode) {
		case 0x31:
			[doc playPause];
			break;
		default:
			[super keyDown:theEvent];
			break;
	}
}

-(void)scrollWheel:(NSEvent *)theEvent {
	DWLog(@"f: %f", theEvent.scrollingDeltaX);
	[doc shuttle:theEvent.scrollingDeltaX];
}

@end
