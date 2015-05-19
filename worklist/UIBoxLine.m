//
//  UIBoxLine.m
//  worklist
//
//  Created by iobit on 15/5/18.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "UIBoxLine.h"

@implementation UIBoxLine

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor grayColor] setFill];
    NSRectFill(dirtyRect);
}

@end
