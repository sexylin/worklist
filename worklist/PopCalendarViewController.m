//
//  PopCalendarViewController.m
//  worklist
//
//  Created by iobit on 15/5/19.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "PopCalendarViewController.h"

@interface PopCalendarViewController ()

@end

@implementation PopCalendarViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _picker.minDate = [NSDate date];
    _hourPicker.minDate = [NSDate date];
    
    _popOver = [[NSPopover alloc]init];
    _popOver.behavior = NSPopoverBehaviorSemitransient;
    _popOver.delegate = self;
    
    NSViewController *vc = [[NSViewController alloc]init];
    vc.view = self.view;
    [_popOver setContentViewController:vc];
}

- (void)showInView:(NSView *)view{
    if(![_popOver isShown]){
        [_popOver showRelativeToRect:NSZeroRect ofView:view preferredEdge:CGRectMinYEdge];
    }
}

- (void)close{
    [_popOver close];
}

#pragma mark ---- button methods
- (IBAction)oneHourLater:(id)sender{
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:60*60];
    _picker.dateValue = newDate;
    _hourPicker.dateValue = newDate;
    [self close];
}

- (IBAction)threeHoursLater:(id)sender{
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:3*60*60];
    _picker.dateValue = newDate;
    _hourPicker.dateValue = newDate;
    [self close];
}

- (IBAction)tomorrow:(id)sender{
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:24*60*60];
    _picker.dateValue = newDate;
    _hourPicker.dateValue = newDate;
    [self close];
}

- (IBAction)aWeekLater:(id)sender{
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:7*24*60*60];
    _picker.dateValue = newDate;
    _hourPicker.dateValue = newDate;
    [self close];
}

- (IBAction)oneMonthLater:(id)sender{
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:30*24*60*60];
    _picker.dateValue = newDate;
    _hourPicker.dateValue = newDate;
    [self close];
}

- (void)setCompletionHandler:(void (^)(NSString *dateFormat))handler{
    _completionHandler = [handler copy];
}

- (IBAction)clickHourPicker:(NSDatePicker *)sender{
    NSDate *date = sender.dateValue;
    _picker.dateValue = date;
}

- (IBAction)clickPicker:(NSDatePicker *)sender{
    NSDate *date = sender.dateValue;
    _hourPicker.dateValue = date;
}

- (void)popoverDidClose:(NSNotification *)notification{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.timeZone = [NSTimeZone systemTimeZone];
    dateFormat.dateFormat = @"YYYY/MM/dd HH:mm";
    _completionHandler([dateFormat stringFromDate:_picker.dateValue]);
}
@end
