//
//  DWVideoView.m
//  DWVideo
//
//  Created by Martin Delille on 11/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideoView.h"

@implementation DWVideoView {
	AVPlayerLayer * playerLayer;
}

-(AVPlayer *)player {
	return playerLayer.player;
}

-(void)setPlayer:(AVPlayer *)player {
	self.wantsLayer = YES;
	playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
	playerLayer.frame = self.bounds;
	playerLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
	playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.layer addSublayer:playerLayer];
}

@end
