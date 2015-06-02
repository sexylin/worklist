//
//  SLTask.m
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "SLTask.h"

@implementation SLTask
@synthesize endDate,category,taskDescription,addDescription,isComplete,createDate,taskID;

- (id)init{
    if(self = [super init]){
        self.endDate = [NSDate date];
        self.category = @"";
        self.taskDescription = @"";
        self.addDescription = @"";
        self.isComplete = NO;
        self.createDate = [NSDate date];
        self.taskID = 0;
    }
    return self;
}
@end
