//
//  SLStrechLabel.m
//  worklist
//
//  Created by iobit on 6/4/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import "SLStrechLabel.h"

@implementation SLStrechLabel

- (void)drawRect:(NSRect)dirtyRect {
    NSSize size = [self titleSize];
    self.frame = NSMakeRect(NSMinX(self.frame), NSMinY(self.frame), size.width, NSHeight(self.frame));
    [super drawRect:dirtyRect];
    // Drawing code here.
}

- (NSSize)titleSize{
    if(self.stringValue){
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.stringValue attributes:@{NSFontAttributeName:self.font}];
        
        NSSize size = NSMakeSize(str.size.width+5, str.size.height);
        return size;
    }else{
        return self.frame.size;
    }
}

@end
