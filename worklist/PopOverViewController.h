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
    IBOutlet UIView *_contentView;
    IBOutlet NSDatePicker *_datePicker;
    NSPopover *_datePop;
    IBOutlet NSView *_popView;
    IBOutlet NSTextView *_descriptionTxt;
    IBOutlet NSTextFielAddition *_categoryText;
    IBOutlet NSTextFielAddition *_dateText;
}
@end
