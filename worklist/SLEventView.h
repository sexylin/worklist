//
//  SLEventView.h
//  worklist
//
//  Created by iobit on 5/29/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SLEventView;
@protocol SLEventViewDelegate <NSObject>

@optional
- (void)mouseEnterEvent:(SLEventView *)view;
- (void)mouseExitEvent:(SLEventView *)view;
@end

@interface SLEventView : NSView{
    BOOL   _mouseIn;
}
@property (nonatomic,retain)NSColor *backgorudColor;
@property (nonatomic,retain)NSColor *mouseinColor;
@property (nonatomic,assign)NSObject <SLEventViewDelegate> *delegate;
@end
