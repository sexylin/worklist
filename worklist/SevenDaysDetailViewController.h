//
//  SevenDaysDetailViewController.h
//  worklist
//
//  Created by iobit on 15/5/25.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SLTask;
@interface SevenDaysDetailViewController : NSViewController
@property (assign)IBOutlet NSView *contentView;
@property (assign)IBOutlet NSScrollView *scroll;
@end

@interface OneDayDetailView : NSView
@property (assign)IBOutlet NSTextField *dayText;
@property (assign)IBOutlet NSTextField *weekText;
@property (assign)IBOutlet NSTextField *dateText;
@property (nonatomic,retain)NSDate *date;
@end

@interface TaskRowView : NSView{
    SLTask *_task;
}
@property (assign)IBOutlet NSTextField *taskDescription;
@property (assign)IBOutlet NSTextField *endDateText;
@property (assign)IBOutlet NSButton *checkButton;
@property (assign)IBOutlet NSButton *pushoffButton;
@property (nonatomic,retain)SLTask *task;

- (void)setTask:(SLTask *)task;
@end