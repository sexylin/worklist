//
//  CommonFunction.h
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@class SLTask;
@interface CommonFunction : NSObject
+ (void)createSqlite;
+ (NSDate *)dateFromString:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (void)modifyTaskID:(NSInteger)t_id Key:(NSString *)key value:(id)value;
+ (NSInteger)maxID;
+ (NSMutableArray *)allTasks;
+ (void)createTask:(SLTask *)task;
+ (NSMutableArray *)tasksByCreateDate:(NSDate *)crDate;
+ (NSMutableArray *)tasksByEndDate:(NSDate *)crDate;
+ (NSRect)stringSizeBoundsToSize:(NSSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)atts string:(NSString *)str;
+ (NSString *)onlyMonthAndDate:(NSDate *)date;
+ (NSString *)dayDescription:(NSDate *)date;
+ (NSString *)hourAndMinutesDescription:(NSDate *)date;
@end
