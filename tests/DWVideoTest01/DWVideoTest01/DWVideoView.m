//
//  DWVideoView.m
//  DWVideoTest01
//
//  Created by Martin Delille on 05/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideoView.h"

@implementation DWVideoView {
	AVPlayerLayer * playerLayer;
}

-(AVPlayer *)player {
	return [playerLayer player];
}

-(void)setPlayer:(AVPlayer *)player {
	self.wantsLayer = YES;
	playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
	playerLayer.frame = self.bounds;
	[self.layer addSublayer:playerLayer];
}


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

-(void)viewDidEndLiveResize {
	DWLog(@"");
	playerLayer.frame = self.bounds;
}
@end
