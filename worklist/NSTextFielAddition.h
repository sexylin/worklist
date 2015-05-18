//
//  NSTextFielAddition.h
//  worklist
//
//  Created by iobit on 15/5/12.
//  Copyright (c) 2015年 sexylin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol NSTextFieldAddtionDelegate <NSObject>

- (void)textfieldWillBeginEditting:(NSTextField *)field;
- (void)textfieldResignFirstResponder:(NSTextField *)field;

@end

@interface NSTextFielAddition : NSTextField

@property (assign)IBOutlet NSObject <NSTextFieldAddtionDelegate>*editDelegate;
@end
