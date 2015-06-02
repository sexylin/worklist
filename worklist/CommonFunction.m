//
//  CommonFunction.m
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "CommonFunction.h"
#import <sqlite3.h>
#import "SLTask.h"
#import "SLUser.h"

@implementation CommonFunction

+ (void)createSqlite{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dbPath = [[NSBundle mainBundle]pathForResource:@"user_data" ofType:@"sqlite"];
    if(![fm fileExistsAtPath:dbPath]){
        
    }
}

+ (NSString *)DBPath{
    return [[NSBundle mainBundle]pathForResource:@"user_data" ofType:@"sqlite"];
}

+ (void)modifyTaskID:(NSInteger)t_id Key:(NSString *)key value:(id)value{
    
}

+ (NSInteger)maxID{
    SLUser *user = [SLUser shareUser];
    NSInteger maxID = 1;
    for(SLTask *task in user.tasks){
        if(task.taskID > maxID) maxID = task.taskID;
    }
    return maxID;
}

+ (NSDate *)dateFromString:(NSString *)dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.timeZone = [NSTimeZone systemTimeZone];
    df.dateFormat = @"YYYY/MM/dd HH:mm";
    NSDate *date = [df dateFromString:dateFormat];
    if(!date) return [NSDate date];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.timeZone = [NSTimeZone systemTimeZone];
    df.dateFormat = @"YYYY/MM/dd HH:mm";
    NSString *string = [df stringFromDate:date];
    if(!string) return [df stringFromDate:[NSDate date]];
    return string;
}

+ (NSMutableArray *)allTasks{
    NSMutableArray *tasks = [NSMutableArray array];
    sqlite3 *db;
    sqlite3_stmt *stmt;
    NSString *dbPath = [CommonFunction DBPath];
    if(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"SELECT * from task_list"];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK){
            while (sqlite3_step(stmt) != SQLITE_DONE) {
                SLTask *task = [[SLTask alloc]init];
                task.taskID = sqlite3_column_int(stmt, 0);
                task.taskDescription = [[NSString alloc]initWithUTF8String:sqlite3_column_text(stmt, 3)];
                task.createDate = [CommonFunction dateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 1)]];
                task.endDate = [CommonFunction dateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 2)]];
                task.isComplete = sqlite3_column_int(stmt, 6);
                task.addDescription = [[NSString alloc]initWithUTF8String:sqlite3_column_text(stmt, 5)];
                task.category = [NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 4)];
                [tasks addObject:task];
                [task release];
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(db);
    }
    return tasks;
}

+ (void)createTask:(SLTask *)task{
    task.taskID = [CommonFunction maxID]+1;
    sqlite3 *db;
    sqlite3_stmt *stmt;
    NSString *dbPath = [CommonFunction DBPath];
    if(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO task_list('task_id','create_time','end_time','desription','category','add_description','is_complete') VALUES ('%ld','%@','%@','%@','%@','%@','%ld')",task.taskID,[CommonFunction stringFromDate:task.createDate],[CommonFunction stringFromDate:task.endDate],task.taskDescription,task.category,task.addDescription,task.isComplete];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK){
            char *error = NULL;
            sqlite3_exec(db, [sql UTF8String], nil, nil, &error);
            if(error){
                NSLog(@"%s",error);
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(db);
    }
}

+ (void)updateTask:(SLTask *)task{
    sqlite3 *db;
    sqlite3_stmt *stmt;
    NSString *dbPath = [CommonFunction DBPath];
    if(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"UPDATE task_list set 'create_time'='%@','end_time'='%@','desription'='%@','category'='%@','add_description'='%@','is_complete'=%ld where task_id=%ld",[CommonFunction stringFromDate:task.createDate],[CommonFunction stringFromDate:task.endDate],task.taskDescription,task.category,task.addDescription,task.isComplete,task.taskID];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK){
            char *error = NULL;
            sqlite3_exec(db, [sql UTF8String], nil, nil, &error);
            if(error){
                NSLog(@"%s",error);
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(db);
    }
}

+ (NSRect)stringSizeBoundsToSize:(NSSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)atts string:(NSString *)str{
    NSRect rect = [str boundingRectWithSize:size options:options attributes:atts];
    return rect;
}

+ (NSMutableArray *)tasksByCreateDate:(NSDate *)crDate{
    NSString *monthAndDate = [CommonFunction onlyMonthAndDate:crDate];
    
    NSMutableArray *tasks = [NSMutableArray array];
    sqlite3 *db;
    sqlite3_stmt *stmt;
    NSString *dbPath = [CommonFunction DBPath];
    if(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"SELECT * from task_list"];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK){
            while (sqlite3_step(stmt) != SQLITE_DONE) {
                NSDate *dbdate = [CommonFunction dateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 1)]];
                NSString *dbMonthAndDate=  [CommonFunction onlyMonthAndDate:dbdate];
                if([dbMonthAndDate isEqualToString:monthAndDate]){
                    SLTask *task = [[SLTask alloc]init];
                    task.taskID = sqlite3_column_int(stmt, 0);
                    task.taskDescription = [[NSString alloc]initWithUTF8String:sqlite3_column_text(stmt, 3)];
                    task.createDate = [CommonFunction dateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 1)]];
                    task.endDate = dbdate;
                    task.isComplete = sqlite3_column_int(stmt, 6);
                    task.addDescription = [[NSString alloc]initWithUTF8String:sqlite3_column_text(stmt, 5)];
                    task.category = [NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 4)];
                    [tasks addObject:task];
                    [task release];
                }
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(db);
    }
    return tasks;
}

+ (NSMutableArray *)tasksByEndDate:(NSDate *)crDate{
    NSString *monthAndDate = [CommonFunction onlyMonthAndDate:crDate];
    
    NSMutableArray *tasks = [NSMutableArray array];
    sqlite3 *db;
    sqlite3_stmt *stmt;
    NSString *dbPath = [CommonFunction DBPath];
    if(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"SELECT * from task_list"];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK){
            while (sqlite3_step(stmt) != SQLITE_DONE) {
                NSDate *dbdate = [CommonFunction dateFromString:[NSString stringWithCString:(const char *)sqlite3_column_text(stmt, 2)  encoding:NSUTF8StringEncoding]];
                NSString *dbMonthAndDate=  [CommonFunction onlyMonthAndDate:dbdate];
                if([dbMonthAndDate isEqualToString:monthAndDate]){
                    SLTask *task = [[SLTask alloc]init];
                    task.taskID = sqlite3_column_int(stmt, 0);
                    task.taskDescription = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                    task.createDate = [CommonFunction dateFromString:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)]];
                    task.endDate = dbdate;
                    task.isComplete = sqlite3_column_int(stmt, 6);
                    task.addDescription = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
                    task.category = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                    [tasks addObject:task];
                    [task release];
                }
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(db);
    }
    return tasks;
}

+ (NSString *)onlyMonthAndDate:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.timeZone = [NSTimeZone systemTimeZone];
    df.dateFormat = @"YYYY/MM/dd";
    NSString *string = [df stringFromDate:date];
    if(!string) return [df stringFromDate:[NSDate date]];
    return string;
}

+ (NSString *)fullDateDescription:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.timeZone = [NSTimeZone systemTimeZone];
    df.dateFormat = @"YYYY/MM/dd HH:mm";
    NSString *string = [df stringFromDate:date];
    if(!string) return [df stringFromDate:[NSDate date]];
    return string;
}

+ (NSString *)dayDescription:(NSDate *)date{
    NSCalendar *calendar=  [NSCalendar currentCalendar];
    NSArray *monthSymb = [calendar monthSymbols];
    NSDateComponents *dateCom = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:date];
    
    NSInteger month = [dateCom month];
    NSInteger day = [dateCom day];
    NSInteger year = [dateCom year];
    
    NSString *monthString = [monthSymb objectAtIndex:month-1];
    NSString *dayDescription = [NSString stringWithFormat:@"%@ %ld , %ld",monthString,day,year];
    return dayDescription;
}

+ (NSString *)hourAndMinutesDescription:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.timeZone = [NSTimeZone systemTimeZone];
    df.dateFormat = @"HH:mm";
    NSString *string = [df stringFromDate:date];
    if(!string) return [df stringFromDate:[NSDate date]];
    return string;
}
@end
