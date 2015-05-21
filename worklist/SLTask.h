//
//  SLTask.h
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLTask : NSObject
@property (nonatomic,retain)NSDate *endDate;
@property (nonatomic,copy)NSString *taskDescription;
@property (nonatomic,copy)NSString *category;
@property (nonatomic,assign)NSInteger isComplete;
@property (nonatomic,retain)NSDate *createDate;
@property (nonatomic,copy)NSString *addDescription;
@property (nonatomic,assign)NSInteger taskID;
@end
