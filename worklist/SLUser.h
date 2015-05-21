//
//  SLUser.h
//  worklist
//
//  Created by iobit on 15/5/21.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLUser : NSObject
@property (nonatomic,retain)NSMutableArray *tasks;

+ (SLUser *)shareUser;
@end
