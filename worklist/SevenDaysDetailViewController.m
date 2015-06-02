//
//  SevenDaysDetailViewController.m
//  worklist
//
//  Created by iobit on 15/5/25.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "SevenDaysDetailViewController.h"
#import "SLTask.h"
#import "CommonFunction.h"
#import "NSColor+AMC.h"
#import "SLTextFiled.h"
#import "common.h"

@interface SevenDaysDetailViewController (){
    NSMutableArray *_sevenDays;
}

@end

@implementation SevenDaysDetailViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateView) name:POST_UPDATE_SEVENDAYS_NOTI object:nil];
    _detailDic = [[NSMutableDictionary alloc]init];
    [self alignView];
}

- (void )initSevenDays{
    if(!_sevenDays){
        _sevenDays = [[NSMutableArray alloc]init];
    }else{
        return;
    }
    
    NSDate *now = [NSDate date];
    for(int i=0;i<7;i++){
        NSDate *date = [now dateByAddingTimeInterval:24*60*60*i];
        [_sevenDays addObject:date];
    }
    
    [_sevenDays sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate *date1 = (NSDate *)obj1;
        NSDate *date2 = (NSDate *)obj2;
        
        if([date1 earlierDate:date2] == date1){
            return  NSOrderedAscending;
        }else if ([date1 earlierDate:date2] == date2){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
        
    }];
}

- (void)updateView{
    [self alignView];
}

- (void)alignView{
    [self initSevenDays];
    NSInteger count = [_sevenDays count];
    
    float mainHeight = NSHeight(self.view.frame);
    
    float yOrign = mainHeight-15;
    for(NSInteger i=0;i<count;i++){
        NSDate *date = [_sevenDays objectAtIndex:i];
        OneDayDetailView *onedayView = [_detailDic objectForKey:date];
        if(!onedayView){
            onedayView = [SevenDaysDetailViewController oneDayDetailView:date];
            [_detailDic setObject:onedayView forKey:date];
        }else{
            [onedayView updateRowView];
        }
        onedayView.frame = NSMakeRect(NSMinX(onedayView.frame), yOrign-NSHeight(onedayView.frame), NSWidth(onedayView.frame), NSHeight(onedayView.frame));
        yOrign -= NSHeight(onedayView.frame);
        [self.contentView addSubview:onedayView];
    }
    
    yOrign -= 15;
    float ySize = yOrign>0?NSHeight(self.view.frame):NSHeight(self.view.frame)-yOrign;
    self.contentView.frame = NSMakeRect(0, 0, NSWidth(self.contentView.frame), ySize);
    [self.scroll setDocumentView:self.contentView];
}

+ (OneDayDetailView *)oneDayDetailView:(NSDate *)date{
    OneDayDetailView *onedayView = nil;
    NSArray *levelObjs = nil;
    BOOL suc = [[NSBundle mainBundle]loadNibNamed:@"SevenDaysDetailViewController" owner:nil topLevelObjects:&levelObjs];
    if(suc){
        for(id obj in levelObjs){
            if([[obj class]isSubclassOfClass:[OneDayDetailView class]]){
                onedayView = obj;
                [onedayView setDate:date];
            }
        }
    }
    return onedayView;
}

@end

@implementation OneDayDetailView{
    NSMutableArray *_tasks;
    NSMutableDictionary *_rowDics;
}
@synthesize date = _date;

- (void)awakeFromNib{
    [super awakeFromNib];
    _rowDics = [[NSMutableDictionary alloc]init];
}

- (void)setDate:(NSDate *)date{
    _date = [date retain];
    if(_tasks){
        [_tasks removeAllObjects];
    }else{
        _tasks = [[NSMutableArray alloc]init];
    }
    
    self.dateText.stringValue = [CommonFunction dayDescription:_date];
    
    
    NSMutableArray *dateTasks = [CommonFunction tasksByEndDate:_date];
    [dateTasks sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        SLTask *task1 = (SLTask *)obj1;
        SLTask *task2 = (SLTask *)obj2;
        if([task1.endDate earlierDate:task2.endDate] == task1.endDate){
            return NSOrderedAscending;
        }else if ([task1.endDate earlierDate:task2.endDate] == task2.endDate){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    [_tasks addObjectsFromArray:dateTasks];
    [self alignView];
}

- (void)updateRowView{
    
    NSMutableArray *removeArr = [NSMutableArray array];
    for(NSView *subView in self.subviews){
        if([[subView class]isSubclassOfClass:[TaskRowView class]]){
            [removeArr addObject:subView];
        }
    }
    
    for(NSView *row in removeArr){
        [row removeFromSuperview];
    }
    
    [self setDate:_date];
}

- (void)alignView{
    NSInteger count = [_tasks count];
    float yOrign = 10;
    for(NSInteger i=0;i<count;i++){
        SLTask *task = [_tasks objectAtIndex:i];
        TaskRowView *row = [OneDayDetailView taskRowView:task];
        row.frame = NSMakeRect(0, yOrign, NSWidth(row.frame), NSHeight(row.frame));
        yOrign += NSHeight(row.frame);
        [self addSubview:row];
    }
    
    self.frame = NSMakeRect(NSMinX(self.frame), NSMinY(self.frame), NSWidth(self.frame), yOrign+30);
    self.dayText.frame = NSMakeRect(NSMinX(self.dayText.frame), yOrign, NSWidth(self.dayText.frame), NSHeight(self.dayText.frame));
    self.weekText.frame = NSMakeRect(NSMaxX(self.dayText.frame)+5, NSMinY(self.dayText.frame)+4, NSWidth(self.weekText.frame), NSHeight(self.weekText.frame));
    self.dateText.frame = NSMakeRect(NSMaxX(self.weekText.frame)+5, NSMinY(self.weekText.frame), NSWidth(self.dateText.frame), NSHeight(self.dateText.frame));
    self.dateText.stringValue = [CommonFunction dayDescription:_date];
    
}

+ (TaskRowView *)taskRowView:(SLTask *)task{
    TaskRowView *row = nil;
    NSArray *levelObjs = nil;
    BOOL suc = [[NSBundle mainBundle]loadNibNamed:@"SevenDaysDetailViewController" owner:nil topLevelObjects:&levelObjs];
    if(suc){
        for(id obj in levelObjs){
            if([[obj class]isSubclassOfClass:[TaskRowView class]]){
                row = obj;
                [row setTask:task];
            }
        }
    }
    return row;
}

@end

@implementation TaskRowView
@synthesize task = _task;

- (void)setTask:(SLTask *)task{
    _task = [task retain];
    
    NSRect descriptionRect = [CommonFunction stringSizeBoundsToSize:self.taskDescription.frame.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.taskDescription.font} string:_task.taskDescription];
    
    self.frame = NSMakeRect(NSMinX(self.frame), NSMinY(self.frame), NSWidth(self.frame), NSHeight(descriptionRect)+25);
    self.cellView.frame = NSMakeRect(NSMinX(self.cellView.frame), NSMinY(self.cellView.frame), NSWidth(self.cellView.frame), NSHeight(self.frame));
    
    self.taskDescription.frame = NSMakeRect(NSMinX(self.taskDescription.frame), NSMaxY(self.endDateText.frame)-5, NSWidth(self.taskDescription.frame), NSHeight(descriptionRect)+5);
    self.taskDescription.stringValue = _task.taskDescription;
    self.checkButton.frame = NSMakeRect(NSMinX(self.checkButton.frame), NSMaxY(self.taskDescription.frame)-NSHeight(self.checkButton.frame)-2, NSWidth(self.checkButton.frame), NSHeight(self.checkButton.frame));
    
    self.cellView.delegate = self;
    self.cellView.mouseinColor = AMCMakeColor(231, 231, 231, 1.0f);
    self.cellView.backgorudColor = AMCMakeColor(255, 255, 255, 1.0f);
    
    self.endDateText.stringValue = [CommonFunction hourAndMinutesDescription:_task.endDate];
    self.endDateText.drawUnderLine = YES;
    self.endDateText.underLineColor = AMCMakeColor(169, 60, 32, 1.0f);
}

- (IBAction)clickPushOff:(NSButton *)sender{
    if(!_calendar){
        _calendar = [[PopCalendarViewController alloc]initWithNibName:@"PopCalendarViewController" bundle:nil];
    }
    _calendar.selectDate = _task.endDate;
    [_calendar setCompletionHandler:^(NSDate *date) {
        _task.endDate = date;
        [CommonFunction updateTask:_task];
        self.endDateText.stringValue = [CommonFunction hourAndMinutesDescription:date];
        [[NSNotificationCenter defaultCenter]postNotificationName:POST_UPDATE_SEVENDAYS_NOTI object:nil];
    }];
    [_calendar showInView:sender];
}

#pragma mark - SLEventViewDelegate
- (void)mouseEnterEvent:(SLEventView *)view{
    [self.pushoffButton setHidden:NO];
}
- (void)mouseExitEvent:(SLEventView *)view{
    [self.pushoffButton setHidden:YES];
}
@end