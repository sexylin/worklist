//
//  SLItemView.h
//  worklist
//
//  Created by iobit on 6/3/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLStrechLabel.h"
#import "SLEventView.h"

enum{
    SLItemNone = 0,
    SLItemOverdue,
    SLItemNext7Days,
    SLItemCompleted,
};
typedef NSUInteger SLItemModule;

@class SLItemView;
@protocol SLItemViewDelegate <NSObject>

- (void)clickItem:(SLItemView *)item;

@end

@interface SLItemView : NSView<SLEventViewDelegate>
+ (SLItemView *)initItem;

@property (nonatomic, assign) NSObject <SLItemViewDelegate> *delegate;
@property (assign) SLEventView *backgroudView;
@property (assign) NSImageView *icon;
@property (assign) SLStrechLabel *titleLabel;
@property (assign) SLStrechLabel *countLabel;
@property (nonatomic, assign) SLItemModule module;
@end
