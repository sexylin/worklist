//
//  PopOverViewController.m
//  worklist
//
//  Created by iobit on 15/5/8.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "PopOverViewController.h"
#import "UIView.h"
#import "common.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
    UIView *backView = (UIView *)self.view;
    backView.backgroundColor = [NSColor whiteColor];
    
    _tabbarView.backgroundColor = [NSColor whiteColor];
}

- (IBAction)clickAlarm:(NSButton *)sender{
    if(sender.state == NSOnState){
        sender.image = [NSImage imageNamed:@"alarm_on"];
    }else{
        sender.image = [NSImage imageNamed:@"alarm_off"];
    }
}

- (IBAction)clickCalendar:(NSButton *)sender{
    [__AppDelegate__.calendar setCompletionHandler:^(NSString *dateFormat) {
        _dateText.stringValue = dateFormat;
    }];
    [__AppDelegate__.calendar showInView:sender];
}

@end
