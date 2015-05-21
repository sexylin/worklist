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
#import "SLTask.h"
#import "CommonFunction.h"
#import "SLUser.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _contentView.backgroundColor = [NSColor whiteColor];
    
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

- (IBAction)clickAddList:(NSButton *)button{
    NSString *description = _descriptionTxt.string;
    NSString *category = _categoryText.stringValue;
    NSString *dateString = _dateText.stringValue;
    if([description length] && [category length] && [dateString length]){
        SLTask *task = [[SLTask alloc]init];
        task.taskDescription = description;
        task.category=  category;
        task.endDate = [CommonFunction dateFromString:dateString];
        task.createDate = [NSDate date];
        task.addDescription = @"";
        task.isComplete = 0;
        [CommonFunction createTask:task];
        [task release];
    }else{
        if([category length] == 0){
            _categoryText.wrong = YES;
            [_categoryText setNeedsDisplay];
        }
        
        if([dateString length] == 0){
            _dateText.wrong = YES;
            [_dateText setNeedsDisplay];
        }
    }
}

@end
