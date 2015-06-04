//
//  SLItemView.m
//  worklist
//
//  Created by iobit on 6/3/15.
//  Copyright (c) 2015 sexylin. All rights reserved.
//

#import "SLItemView.h"
#import "NSColor+AMC.h"

@implementation SLItemView
@synthesize delegate;
@synthesize icon,titleLabel,countLabel,backgroudView;
@synthesize module;

+ (SLItemView *)initItem{
    NSArray *topLevels = nil;
    SLItemView *item = nil;
    BOOL suc = [[NSBundle mainBundle]loadNibNamed:@"SLItemView" owner:nil topLevelObjects:&topLevels];
    if(suc){
        for( id obj in topLevels){
            if([[obj class]isSubclassOfClass:[SLItemView class]]){
                item = obj;
            }
        }
    }
    return item;
}

- (id)initWithFrame:(NSRect)frameRect{
    if(self = [super initWithFrame:frameRect]){
        self.backgroudView = [[SLEventView alloc]initWithFrame:NSMakeRect(0, 0, NSWidth(frameRect), NSHeight(frameRect))];
        
        self.icon = [[NSImageView alloc]initWithFrame:NSMakeRect(3,( NSHeight(self.frame)-22)/2.0f, 22, 22)];
        [[self.icon cell]setBordered:NO];
        
        self.titleLabel = [[SLStrechLabel alloc]initWithFrame:NSMakeRect(NSMaxX(self.icon.frame)+5, NSMinY(self.icon.frame)+3, 158, 17)];
        [self.titleLabel setBordered:NO];
        self.titleLabel.backgroundColor = [NSColor clearColor];
        self.titleLabel.editable = NO;
        self.titleLabel.textColor=  AMCMakeColor(131, 131, 131, 1.0f);
        self.titleLabel.font = [NSFont fontWithName:@"Heiti SC" size:14.0f];
        [[self.titleLabel cell]setSendsActionOnEndEditing:YES];
        [self.titleLabel setEnabled:YES];
        [self.titleLabel setSelectable:NO];
        
        
        self.countLabel = [[SLStrechLabel alloc]initWithFrame:NSMakeRect(NSMaxX(self.titleLabel.frame)+3, NSMinY(self.titleLabel.frame), 50, 17)];
        [self.countLabel setBordered:NO];
        self.countLabel.backgroundColor = [NSColor clearColor];
        self.countLabel.textColor=  AMCMakeColor(92, 92, 92, 1.0f);
        self.countLabel.editable = NO;
        self.countLabel.font = [NSFont fontWithName:@"Heiti SC" size:12.0f];
        
        [self addSubview:self.backgroudView];
        [self.backgroudView addSubview:self.icon];
        [self.backgroudView addSubview:self.titleLabel];
        [self.backgroudView addSubview:self.countLabel];
        
    }
    return self ;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroudView.delegate = self;
    self.backgroudView.backgorudColor = [NSColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1.0f];
    self.backgroudView.mouseinColor = AMCMakeColor(255, 255, 255, 1.0f);
    self.countLabel.frame = NSMakeRect(NSMaxX(self.titleLabel.frame)+3, NSMinY(self.titleLabel.frame), 50, 17);
}

- (void)mouseEnterEvent:(SLEventView *)view{
    
}
- (void)mouseExitEvent:(SLEventView *)view{
    
}

- (void)mouseDownEvent:(SLEventView *)view{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickItem:)]){
        [self.delegate clickItem:self];
    }
}
@end
