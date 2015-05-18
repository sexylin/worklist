//
//  NSTextFielAddition.m
//  worklist
//
//  Created by iobit on 15/5/12.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "NSTextFielAddition.h"
#import <sys/event.h>

@implementation NSTextFielAddition

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (BOOL)becomeFirstResponder{
    if(self.editDelegate){
        [self.editDelegate textfieldWillBeginEditting:self];
    }
    return [super becomeFirstResponder];
}

- (NSRect)accessibilityFrameForRange:(NSRange)range{
    return self.bounds;
}
@end
