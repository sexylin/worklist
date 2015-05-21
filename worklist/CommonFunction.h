//
//  CommonFunction.h
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLTask;
@interface CommonFunction : NSObject
+ (void)createSqlite;
+ (NSDate *)dateFromString:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (void)modifyTaskID:(NSInteger)t_id Key:(NSString *)key value:(id)value;
+ (NSInteger)maxID;
+ (NSMutableArray *)allTasks;
+ (void)createTask:(SLTask *)task;
@end
