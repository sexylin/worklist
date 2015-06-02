//
//  SevenDaysDetailViewController.h
//  worklist
//
//  Created by iobit on 15/5/25.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLEventView.h"

@class SLTask;
@interface SevenDaysDetailViewController : NSViewController{
    NSMutableDictionary *_detailDic;
}
@property (assign)IBOutlet NSView *contentView;
@property (assign)IBOutlet NSScrollView *scroll;

- (void)updateView;
@end

@interface OneDayDetailView : NSView
@property (assign)IBOutlet NSTextField *dayText;
@property (assign)IBOutlet NSTextField *weekText;
@property (assign)IBOutlet NSTextField *dateText;
@property (nonatomic,retain)NSDate *date;
- (void)updateRowView;
@end

@class SLTextFiled;
@class PopCalendarViewController;
@interface TaskRowView : NSView<SLEventViewDelegate>{
    SLTask *_task;
    PopCalendarViewController *_calendar;
}
@property (assign)IBOutlet NSTextField *taskDescription;
@property (assign)IBOutlet SLTextFiled *endDateText;
@property (assign)IBOutlet NSButton *checkButton;
@property (assign)IBOutlet NSButton *pushoffButton;
@property (assign)IBOutlet SLEventView *cellView;
@property (nonatomic,retain)SLTask *task;

- (void)setTask:(SLTask *)task;
- (IBAction)clickPushOff:(NSButton *)sender;
@end
