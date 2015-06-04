//
//  HomeViewController.m
//  worklist
//
//  Created by iobit on 15/5/22.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "HomeViewController.h"
#import "UIView.h"
#import "NSColor+AMC.h"
#import "SevenDaysDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    _leftContentView.backgroundColor = AMCMakeColor(239, 239, 239, 1.0f);
    _rightContentView.backgroundColor = AMCMakeColor(255, 255, 255, 1.0f);
    
    _next7Days.icon.image = [NSImage imageNamed:@"calendar"];
    _next7Days.titleLabel.stringValue = @"Next 7 days";
    _next7Days.delegate = self;
    _next7Days.module = SLItemNext7Days;
    
    _overdueItem.icon.image = [NSImage imageNamed:@"calendar"];
    _overdueItem.titleLabel.stringValue = @"Over due tasks";
    _overdueItem.delegate = self;
    _overdueItem.module = SLItemOverdue;
    
}

- (void)clickItem:(SLItemView *)item{
    switch (item.module) {
        case SLItemNext7Days:{
            SevenDaysDetailViewController *sevn = [[SevenDaysDetailViewController alloc]initWithNibName:@"SevenDaysDetailViewController" bundle:nil];
            [_rightContentView addSubview:sevn.view];
        }
            break;
            
        default:
            break;
    }
}

@end
