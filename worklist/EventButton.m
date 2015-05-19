//
//  EventButton.m
//  worklist
//
//  Created by iobit on 15/5/19.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "EventButton.h"
#import "common.h"

@implementation EventButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSTrackingArea *trackArea = [[NSTrackingArea alloc]initWithRect:self.bounds options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside owner:self userInfo:nil];
    [self addTrackingArea:trackArea];
    [trackArea release];
    
    NSString *toolTip = self.identifier;
    if(toolTip){
        _popOver = [[NSPopover alloc]init];
        _popOver.behavior = NSPopoverBehaviorSemitransient;
        NSViewController *vc = [[NSViewController alloc]init];
        
        NSSize size = [self sizeByString:toolTip];
        
        NSTextField *label = [[NSTextField alloc]initWithFrame:NSMakeRect(0, 0, size.width+5, size.height)];
        label.backgroundColor =[NSColor clearColor];
        label.editable = NO;
        label.bordered = NO;
        label.font = [NSFont systemFontOfSize:12.0f];
        label.textColor = AMCMakeColor(92, 92, 92, 92);
        label.stringValue = toolTip;
        
        vc.view = label;
        _popOver.contentViewController = vc;
    }
}

- (NSSize)sizeByString:(NSString *)str{
    NSAttributedString *attStr = [[[NSAttributedString alloc]initWithString:str
                                                                attributes:@{NSFontAttributeName:[NSFont systemFontOfSize:12.0f]}]autorelease];
    return attStr.size;
    
}

- (void)mouseEntered:(NSEvent *)theEvent{
    if(!_normalImage) _normalImage = self.image;
    if(!_alterImage)_alterImage = self.alternateImage;
    
    if(_popOver && ![_popOver isShown]){
        [_popOver showRelativeToRect:NSZeroRect ofView:self preferredEdge:CGRectMaxYEdge];
    }
    
    [self setImage:_alterImage];
    [super mouseEntered:theEvent];
}

- (void)mouseExited:(NSEvent *)theEvent{
    if(!_normalImage) _normalImage = self.image;
    if(!_alterImage)_alterImage = self.alternateImage;
    if(_popOver) [_popOver close];
    
    [self setImage:_normalImage];
    [super mouseExited:theEvent];
}

@end
