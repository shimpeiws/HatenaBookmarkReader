//
//  MenuButton.h
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/18.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIButton
@property NSInteger columNum;
@property NSString*  labelString;
@property CGSize  labelSize;
- (id)initWithFrame:(CGRect)frame columNum:(NSInteger)columNum labelString:(NSString*) labelString ;
@end
