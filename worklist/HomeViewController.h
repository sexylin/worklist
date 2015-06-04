//
//  HomeViewController.h
//  worklist
//
//  Created by iobit on 15/5/22.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLItemView.h"

@class UIView;
@class SLItemView;
@interface HomeViewController : NSViewController<SLItemViewDelegate>{
    IBOutlet UIView *_leftContentView;
    IBOutlet UIView *_rightContentView;
    
    IBOutlet SLItemView *_overdueItem;
    IBOutlet SLItemView *_next7Days;
}

@end
