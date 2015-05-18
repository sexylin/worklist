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
    [[NSColor grayColor] set];
    NSLog(@"%@",NSStringFromRect(self.frame));
    NSRectFill(CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 1));
}

@end
