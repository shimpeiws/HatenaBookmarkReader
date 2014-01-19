//
//  MasterViewController.h
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/29.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HatenaBookmarkUtil.h"
#import "MenuViewController.h"
@interface MasterViewController : UITableViewController <HatenaBookmarkUtilDelegate>
@property NSIndexPath *indexPath;
-(IBAction)showMenu;
-(void)getFavorieItems;
-(void)getBookmarkedItems;
@end
