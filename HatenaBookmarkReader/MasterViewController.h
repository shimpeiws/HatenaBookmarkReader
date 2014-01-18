//
//  MasterViewController.h
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/29.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HatenaBookmarkUtil.h"
//@protocol HatenaBookmarkUtilDelegate
//@required //requiredが指定されてると必ず実装する必要がある
//- (void)finishLoading:(id)sender;
//@end
@interface MasterViewController : UITableViewController <HatenaBookmarkUtilDelegate>
-(IBAction)showMenu;
@end
