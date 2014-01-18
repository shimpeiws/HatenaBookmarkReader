//
//  MenuButton.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/18.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

- (id)initWithFrame:(CGRect)frame
{
    if(!self.columNum) {
     self.columNum = 0;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(10, 200 * self.columNum, self.labelSize.width, 30)];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:_labelString forState:UIControlStateNormal];
    }
    return self;
}

// 引数ありのイニシャライザの実装
- (id)initWithFrame:(CGRect)frame columNum:(NSInteger)columNum labelString:(NSString*) labelString {
//    self = [super init];
    if (self != nil) {
        self.columNum = columNum;
        //全体のサイズを取得
        //フォント
        UIFont *font = [UIFont fontWithName:@"Helvetica-Bold"size:18];
        //最大サイズ
        //表示最大サイズ
        CGSize bounds = CGSizeMake(200, 30);
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
