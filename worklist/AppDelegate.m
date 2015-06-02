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
#import "UIView.h"
#import "NSColor+AMC.h"
#import "INAppStoreWindow.h"
#import "INWindowButton.h"
#import "HomeViewController.h"
#import "SevenDaysDetailViewController.h"

@interface AppDelegate ()

@property (assign) IBOutlet INAppStoreWindow *window;
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

- (void)awakeFromNib{
    [super awakeFromNib];
//    _leftContentView.backgroundColor = AMCMakeColor(235, 235, 235, 1.0f);
//    _rightContentView.backgroundColor = AMCMakeColor(255, 255, 255, 1.0f);
    self.window.titleBarHeight = 32;
    
    self.window.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect,
                                         CGRectEdge edge, CGPathRef clippingPath) {
        CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextAddPath(ctx, clippingPath);
        CGContextClip(ctx);
        NSImage* image1 =[NSImage imageNamed:@"left_bar"];
        float left_width = 300;
        [image1 drawInRect:NSMakeRect(0, 0, left_width, 32) fromRect:NSMakeRect(0, 0, image1.size.width, 32) operation:NSCompositeSourceOver fraction:1.0];
        NSImage* image2 =[NSImage imageNamed:@"right_bar"];

        [image2 drawInRect:NSMakeRect(left_width, 0, NSWidth(self.window.frame) - left_width, 32) fromRect:NSMakeRect(0, 0, image2.size.width, 32) operation:NSCompositeSourceOver fraction:1.0];
    };
    
    HomeViewController *homeVC = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//    homeVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.window.frame), CGRectGetHeight(self.window.frame));
    [self.window.contentView addSubview:homeVC.view];
    
    [self.window center];
}

- (void)setupCloseButton
{
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    self.window.closeButton = closeButton;
}

- (void)setupMinimizeButton
{
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    self.window.minimizeButton = button;
}

- (void)setupZoomButton
{
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    self.window.zoomButton = button;
}

- (void)popUpStatusView{
    if(!_isShow){
        PopOverViewController *contentVC = [[[PopOverViewController alloc]initWithNibName:@"PopOverViewController" bundle:nil]autorelease];
        _popOver.contentViewController = contentVC;
        [_popOver showRelativeToRect:_sysItem.view.bounds ofView:_sysItem.view preferredEdge:NSMaxYEdge];
        _isShow = YES;
    }else{
        [_popOver close];
        _isShow = NO;
    }
}

- (void)closePop{
    [_popOver close];
    _isShow = NO;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    [self.window makeKeyAndOrderFront:nil];
    return YES;
}

@end
