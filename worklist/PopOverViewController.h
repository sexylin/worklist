//
//  PopOverViewController.h
//  worklist
//
//  Created by iobit on 15/5/8.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSTextFielAddition.h"

@class UIView;
@interface PopOverViewController : NSViewController<NSPopoverDelegate,NSTextFieldAddtionDelegate>{
    IBOutlet UIView *_tabbarView;
    IBOutlet NSTextFielAddition *_categoryText;
    IBOutlet NSTextFielAddition *_dateText;
    IBOutlet NSDatePicker *_datePicker;
    IBOutlet NSBox *_hor1;
    NSPopover *_datePop;
}
@end
