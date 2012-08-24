//
//  DWTimecodeField.m
//  DWUserInterface
//
//  Created by Martin Delille on 22/05/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWTimecodeField.h"

@implementation DWTimecodeField {
	NSUInteger cursorPosition;
}

-(id)init {
    self = [super init];
    if (self) {
//		self.delegate = self;
    }
    
    return self;
}

-(NSRange)currentRange {
	NSRange r;
	r.location = cursorPosition;
	r.length = 1;
	return r;
}

-(void)checkCursorPosition {
	switch (cursorPosition) {
		case 2:
		case 5:
		case 8:
			cursorPosition ++;
			break;
		case 11:
		case 12:
			cursorPosition = 0;
			break;
	}
}

-(void)decCursorPosition {
	switch (cursorPosition) {
		case 0:
			cursorPosition = 12;
		case 3:
		case 6:
		case 9:
			cursorPosition -= 2;
			break;
		default:
			cursorPosition--;
			break;
	}	
}

-(NSRange)textView:(NSTextView *)textView willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange {
	NSLog(@"selection %lu/%lu", newSelectedCharRange.location, newSelectedCharRange.length);
	cursorPosition = newSelectedCharRange.location;
	[self checkCursorPosition];
	return [self currentRange];
}

-(BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString {
	
	if (replacementString.length >1) {
		return NO;
	}
	
	switch ([replacementString characterAtIndex:0]) {
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			return YES;
		case ':':
			cursorPosition+=2;
			[self checkCursorPosition];
			self.currentEditor.selectedRange = [self currentRange];
			return NO;
	}
	
	return NO;
}

-(BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
	NSLog(@"docommand :%@", NSStringFromSelector(commandSelector));
	if (commandSelector == @selector(moveRight:)) {
		cursorPosition++;
		[self checkCursorPosition];
		self.currentEditor.selectedRange = [self currentRange];
		return YES;
	}
	else if (commandSelector == @selector(moveLeft:)) {
		[self decCursorPosition];
		self.currentEditor.selectedRange = [self currentRange];
		return YES;
	}
	return NO;
}

@end
