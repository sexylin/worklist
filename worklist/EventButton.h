//
//  EventButton.h
//  worklist
//
//  Created by iobit on 15/5/19.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EventButton : NSButton{
    NSImage *_normalImage;
    NSImage *_alterImage;
    NSPopover *_popOver;
}

@end
