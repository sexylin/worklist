//
//  SLUser.m
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "SLUser.h"
#import "CommonFunction.h"

@implementation SLUser
@synthesize tasks;

- (id)init{
    if(self = [super init]){
        self.tasks = [NSMutableArray array];
        [self.tasks addObjectsFromArray:[CommonFunction allTasks]];
    }
    return self;
}

+ (SLUser *)shareUser{
    static SLUser *user=nil;
    if(!user){
        user = [[SLUser alloc]init];
    }
    return user;
}

@end
