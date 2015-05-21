//
//  AppDelegate.m
//  worklist
//
//  Created by iobit on 15/5/8.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import "AppDelegate.h"
#import "GVFileNotificationCenter.h"
#import "CommonFunction.h"

@interface AppDelegate ()

@property (assign) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    systemBar = [NSStatusBar systemStatusBar];
    _sysItem = [[systemBar statusItemWithLength:NSVariableStatusItemLength]retain];
    
    NSButton *statsuButton = [[NSButton alloc]initWithFrame:CGRectMake(0, 0, 26, 22)];
    statsuButton.bordered = NO;
    statsuButton.image = [NSImage imageNamed:@"status_icon"];
    statsuButton.target = self;
    statsuButton.action =@selector(popUpStatusView);
    _sysItem.view = statsuButton;
    [CommonFunction createSqlite];
}

- (void)popUpStatusView{
    if(!_isShow){
        [_popOver showRelativeToRect:_sysItem.view.bounds ofView:_sysItem.view preferredEdge:NSMaxYEdge];
        _isShow = YES;
    }else{
        [_popOver close];
        _isShow = NO;
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
