//
//  SLEventView.m
//  worklist
//
//  Created by iobit on 5/29/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import "SLEventView.h"

@implementation SLEventView
@synthesize mouseinColor;
@synthesize backgorudColor;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    if(_mouseIn){
        [self.mouseinColor setFill];
        NSRectFill(dirtyRect);
    }else{
        [self.backgorudColor setFill];
        NSRectFill(dirtyRect);
    }
}

- (id)initWithFrame:(NSRect)frameRect{
    if(self = [super initWithFrame:frameRect]){
        NSTrackingArea *trackArea = [[NSTrackingArea alloc]initWithRect:self.frame options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingInVisibleRect owner:self userInfo:nil];
        [self addTrackingArea:trackArea];
        [trackArea release];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent{
    return YES;
}

- (void)mouseEntered:(NSEvent *)theEvent{
    _mouseIn = YES;
    [self setNeedsDisplay:YES];
    if(self.delegate && [self.delegate respondsToSelector:@selector(mouseEnterEvent:)]){
        [self.delegate mouseEnterEvent:self];
    }
}

- (void)mouseExited:(NSEvent *)theEvent{
    _mouseIn = NO;
    [self setNeedsDisplay:YES];
    if(self.delegate && [self.delegate respondsToSelector:@selector(mouseExitEvent:)]){
        [self.delegate mouseExitEvent:self];
    }
}

- (void)mouseDown:(NSEvent *)theEvent{
    if(self.delegate && [self.delegate respondsToSelector:@selector(mouseDownEvent:)]){
        [self.delegate mouseDownEvent:self];
    }
}
@end
