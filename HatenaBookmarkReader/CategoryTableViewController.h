//
//  CategoryTableViewController.h
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/19.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲートを定義
@protocol CategotyTableDelegate <NSObject>
- (void) categotySelected: (NSInteger) selectedRow;
- (void) testDelegate;
@end

@interface CategoryTableViewController : UITableViewController
@property id<CategotyTableDelegate> delegate;
@end
