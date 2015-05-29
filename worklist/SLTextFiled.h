//
//  SLTextFiled.h
//  worklist
//
//  Created by iobit on 5/29/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SLTextFiled : NSTextField{
    NSPopover *_popOver;
}
@property (assign) BOOL drawUnderLine;
@property (nonatomic,retain) NSColor *underLineColor;

@end
