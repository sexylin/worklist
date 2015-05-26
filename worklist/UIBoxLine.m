//
//  UIBoxLine.m
//  worklist
//
//  Created by iobit on 15/5/18.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "UIBoxLine.h"
#import "NSColor+AMC.h"

@implementation UIBoxLine

- (void)drawRect:(NSRect)dirtyRect {
    [AMCMakeColor(205, 205, 205, 1.0f) setFill];
    NSRectFill(dirtyRect);
}

@end
