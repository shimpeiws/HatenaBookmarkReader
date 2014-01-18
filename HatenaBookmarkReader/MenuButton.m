//
//  MenuButton.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/18.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

#define OFFSET_HEIGHT 50
#define INTERVAL_HEIGHT 75
#define MARGIN_WIDTH 20
#define LABEL_HEIGHT 50



- (id)initWithFrame:(CGRect)frame
{
    if(!self.columNum) {
     self.columNum = 0;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, OFFSET_HEIGHT + (INTERVAL_HEIGHT * self.columNum), self.labelSize.width + MARGIN_WIDTH, LABEL_HEIGHT)];
        [self setBackgroundColor:[self buttonColor:self.columNum]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18];
        [self setTitle:_labelString forState:UIControlStateNormal];
    }
    return self;
}

- (UIColor*)buttonColor:(NSInteger)columNum{
    UIColor* butonColor;
    switch (columNum % 6) {
        case 0:
            butonColor = [UIColor colorWithRed:1.0 green:0.612 blue:0.251 alpha:1.0];
            break;
        case 1:
            butonColor = [UIColor colorWithRed:0.863 green:0.031 blue:0.0 alpha:1.0];
            break;
        case 2:
            butonColor = [UIColor colorWithRed:0.514 green:0.086 blue:0.361 alpha:1.0];
            break;
        case 3:
            butonColor = [UIColor colorWithRed:0.455 green:0.757 blue:0.290 alpha:1.0];
            break;
        case 4:
            butonColor = [UIColor colorWithRed:0.929 green:0.271 blue:0.502 alpha:1.0];
            break;
        case 5:
            butonColor = [UIColor colorWithRed:0.157 green:0.420 blue:0.800 alpha:1.0];
            break;
            
        default:
            butonColor = [UIColor blackColor];
            break;
    }
    return butonColor;
}

// 引数ありのイニシャライザの実装
- (id)initWithFrame:(CGRect)frame columNum:(NSInteger)columNum labelString:(NSString*) labelString {
//    self = [super init];
    if (self != nil) {
        self.columNum = columNum;
        //フォント
        UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18];
        //表示最大サイズ
        CGSize bounds = CGSizeMake(200, 30);
        //全体のサイズを取得
        CGRect rect = [labelString boundingRectWithSize:bounds
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:font}
                                                context:nil];
        self.labelSize = rect.size;

        self.labelString = labelString;
    }
    return [self initWithFrame:frame];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
