//
//  PopOverViewController.m
//  worklist
//
//  Created by iobit on 15/5/8.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "PopOverViewController.h"
#import "UIView.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
    UIView *backView = (UIView *)self.view;
    backView.backgroundColor = [NSColor whiteColor];
    
    _tabbarView.backgroundColor = [NSColor whiteColor];
}

- (BOOL)popoverShouldClose:(NSPopover *)popover{
    return YES;
}
- (void)popoverDidShow:(NSNotification *)notification{
    
}

- (void)popoverDidClose:(NSNotification *)notification{
    NSPopover *pop = notification.object;
    if(pop == _datePop){
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        dateFormat.timeZone = [NSTimeZone systemTimeZone];
        dateFormat.dateFormat = @"YYYY/MM/dd HH:mm";
        _dateText.stringValue = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:_datePicker.dateValue]];
    }
}

- (IBAction)clickAlarm:(NSButton *)sender{
    if(sender.state == NSOnState){
        sender.image = [NSImage imageNamed:@"alarm_on"];
    }else{
        sender.image = [NSImage imageNamed:@"alarm_off"];
    }
}

- (IBAction)clickCalendar:(NSButton *)sender{
    if(!_datePop){
        _datePop = [[NSPopover alloc]init];
        _datePop.behavior = NSPopoverBehaviorSemitransient;
        _datePop.delegate = self;
        _datePicker.dateValue = [NSDate date];
        NSViewController *vc = [[NSViewController alloc]init];
        vc.view = _datePicker;
        [_datePop setContentViewController:vc];
    }
    
    if(![_datePop isShown]){
        [_datePop showRelativeToRect:NSZeroRect ofView:sender preferredEdge:CGRectMinXEdge];
    }
}

- (void)textfieldWillBeginEditting:(NSTextField *)field{
    if(field == _dateText){
        if(!_datePop){
            _datePop = [[NSPopover alloc]init];
            _datePop.behavior = NSPopoverBehaviorSemitransient;
            _datePop.delegate = self;
            _datePicker.dateValue = [NSDate date];
            NSViewController *vc = [[NSViewController alloc]init];
            vc.view = _datePicker;
            [_datePop setContentViewController:vc];
        }
        
        if(![_datePop isShown]){
            [_datePop showRelativeToRect:NSZeroRect ofView:_dateText preferredEdge:CGRectMinXEdge];
        }
    }
}

- (void)textDidEndEditing:(NSNotification *)notification{
    
}

- (void)textfieldResignFirstResponder:(NSTextField *)field{
    if(field == _dateText){
        if([_datePop isShown]){
            [_datePop close];
        }
    }
}
@end
