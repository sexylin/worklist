//
//  SLTextFiled.m
//  worklist
//
//  Created by iobit on 5/29/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import "SLTextFiled.h"

@implementation SLTextFiled
@synthesize drawUnderLine;
@synthesize underLineColor;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    float width = [self titleSize].width;
    self.frame = NSMakeRect(NSMinX(self.frame), NSMinY(self.frame), width+5, NSHeight(self.frame));
    
    if(drawUnderLine){
        NSRect under_line_rect = NSMakeRect(0, NSHeight(self.frame)-1, NSWidth(self.frame), 1);
        if(self.underLineColor){
            [self.underLineColor setFill];
            NSRectFill(under_line_rect);
        }
    }
    // Drawing code here.
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSTrackingArea *trackArea = [[NSTrackingArea alloc]initWithRect:self.bounds options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside owner:self userInfo:nil];
    [self addTrackingArea:trackArea];
    [trackArea release];
    
    _popOver = [[NSPopover alloc]init];
}

- (void)mouseEntered:(NSEvent *)theEvent{
    
}

- (void)mouseExited:(NSEvent *)theEvent{
    
}

- (NSSize)titleSize{
    if(self.stringValue){
        NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:self.stringValue attributes:@{NSFontAttributeName:self.font}];
        return attStr.size;
    }
    return NSZeroRect.size;
}

@end
