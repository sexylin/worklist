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

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    _leftContentView.backgroundColor = AMCMakeColor(235, 235, 235, 1.0f);
    _rightContentView.backgroundColor = AMCMakeColor(255, 255, 255, 1.0f);
}

@end
