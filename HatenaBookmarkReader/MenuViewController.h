//
//  MenuViewController.h
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/05.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryTableViewController.h"
@protocol MenuViewDelegate <NSObject>
- (void)favoriteSelected;
@end
@interface MenuViewController : UIViewController<CategotyTableDelegate>
@end
