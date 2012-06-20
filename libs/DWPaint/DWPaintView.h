//
//  DWPaintView.h
//  BasicPaintTest01
//
//  Created by Martin Delille on 19/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DWPaintView : NSOpenGLView

-(void)drawQuad:(NSRect)rect;
-(void)doPaint;

@end
