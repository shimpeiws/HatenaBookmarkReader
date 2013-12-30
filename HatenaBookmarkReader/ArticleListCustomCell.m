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
        _icon = [self makeLabel: 10 y:5 width:20 height:50];
        _title = [self makeLabel: 20 y:5 width:280 height:50];
        _users = [self makeLabel:250 y:30 width:100 height:50];
        _date = [self makeLabel:10 y:80 width:50 height:10];
        _tags = [self makeLabel:250 y:80 width:100 height:10];
        _title.numberOfLines = 0;
        _users.textColor = [UIColor redColor];
        [_icon setFont:[UIFont systemFontOfSize:14]];
        [_title setFont:[UIFont systemFontOfSize:14]];
        [_users setFont:[UIFont systemFontOfSize:11]];
        [_date setFont:[UIFont systemFontOfSize:11]];
        [_tags setFont:[UIFont systemFontOfSize:11]];
        [self addSubview:_icon];
        [self addSubview:_title];
        [self addSubview:_users];
        [self addSubview:_date];
        [self addSubview:_tags];
        // accessory
        [self setAccessoryType:UITableViewCellAccessoryNone];
    }
    return self;
}

- (UILabel*) makeLabel: (int)x y:(int)y width:(int) width height:(int)height
{
    return [[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)]init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
