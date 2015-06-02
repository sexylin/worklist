//
//  PopCalendarViewController.h
//  worklist
//
//  Created by iobit on 15/5/19.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PopCalendarViewController : NSViewController<NSPopoverDelegate>{
    IBOutlet NSDatePicker *_hourPicker;
    NSPopover *_popOver;
    void (^_completionHandler)(NSDate *date);
}

@property (assign) IBOutlet NSDatePicker *picker;
@property (nonatomic,retain) NSDate *limitMinDate;
@property (nonatomic,retain) NSDate *selectDate;

- (void)showInView:(NSView *)view;
- (void)close;
- (void)setCompletionHandler:(void (^)(NSDate *date))handler;
@end
