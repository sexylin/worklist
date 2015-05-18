//
//  AppDelegate.h
//  worklist
//
//  Created by iobit on 15/5/8.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PopOverViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NSStatusBar *systemBar;
    NSStatusItem *_sysItem;
    IBOutlet PopOverViewController *popVC;
    IBOutlet NSPopover *_popOver;
    BOOL _isShow;
}


@end

