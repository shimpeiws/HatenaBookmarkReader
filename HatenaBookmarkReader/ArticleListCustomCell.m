//
//  ArticleListCustomCell.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/29.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import "ArticleListCustomCell.h"

@implementation ArticleListCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //区切り線の開始位置を0に設定
    self.separatorInset = UIEdgeInsetsZero;;
    if (self) {
        // title
        _title = [[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 50)]init];
        [_title setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_title];
        // accessory
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
