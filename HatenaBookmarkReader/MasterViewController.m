//
//  MasterViewController.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/29.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ArticleListCustomCell.h"
#import "HatenaBookmarkUtil.h"
#import "HatenaBookmarkEntry.h"
#import "IIViewDeckController.h"
#import "MenuViewController.h"

@interface MasterViewController () {
    NSArray * tableDataList;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self setupTableViewStyle];
    [self setupNavigationItem];
    [self setupItems];
}


- (void)getFavorieItems
{
    NSLog(@"getFavorite");
    HatenaBookmarkUtil* hatenaBookMarkUtil = [[HatenaBookmarkUtil alloc]init];
    [hatenaBookMarkUtil setDelegate:self];
    [hatenaBookMarkUtil favoriteEntries:@"shimpeiws"];

}

- (void)getBookmarkedItems
{
    NSLog(@"getBookmarked");
    HatenaBookmarkUtil* hatenaBookMarkUtil = [[HatenaBookmarkUtil alloc]init];
    [hatenaBookMarkUtil setDelegate:self];
    [hatenaBookMarkUtil bookmarkedEntries:@"shimpeiws"];
}

- (void)getCategoryItems:(NSUInteger)categoryId
{
    NSLog(@"getBookmarked");
    HatenaBookmarkUtil* hatenaBookMarkUtil = [[HatenaBookmarkUtil alloc]init];
    [hatenaBookMarkUtil setDelegate:self];
    [hatenaBookMarkUtil entriesByCategory:categoryId];
    
}

- (void)finishLoading:(NSArray*)entryList{
    NSLog(@"loaded");
    NSMutableDictionary *section = [NSMutableDictionary dictionary];
    [section setObject:@"articles" forKey:@"header"];
//    NSMutableDictionary *section = @{@"header":@"articles"};
    NSMutableArray *data = [NSMutableArray array];
    HatenaBookmarkUtil* hatenaBookMarkUtil = [[HatenaBookmarkUtil alloc]init];
    [hatenaBookMarkUtil setDelegate:self];
    for(HatenaBookmarkEntry* entry in entryList) {
        NSDictionary *cell = @{@"title":entry.title, @"url":entry.url, @"icon":@"i", @"usersCount":entry.count, @"postDate":entry.date, @"tags":@[@"ruby", @"security"]};
        [data addObject:cell];
    }
    if (data) {
        [section setObject:data forKey:@"data"];
    }
    
    tableDataList = @[section];

    [self.tableView reloadData];
}

- (void)favoriteSelected
{
    NSLog(@"delegated");
}

- (void)setupItems
{
    HatenaBookmarkUtil* hatenaBookMarkUtil = [[HatenaBookmarkUtil alloc]init];
    [hatenaBookMarkUtil setDelegate:self];
    NSUInteger category = IT;
    [hatenaBookMarkUtil entriesByCategory:category];
}

- (void)setupTableViewStyle
{
//    MenuViewController* leftController = [[MenuViewController alloc] init];
//    self.viewDeckController.leftController = leftController;
//    [self.viewDeckController toggleLeftViewAnimated:YES];
    //IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self leftViewController:leftController];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//   if (window == nil) {
//            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
//    }
//    UIViewController *viewController = window.rootViewController;
//    viewController = deckController;
//    [window makeKeyAndVisible];
    
    self.tableView.separatorColor = [UIColor grayColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

}

- (void)setupNavigationItem
{
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *btn =
    [[UIBarButtonItem alloc]
     initWithTitle:@"MENU"  // ボタンタイトル名を指定
     style:UIBarButtonItemStylePlain  // スタイルを指定（※下記表参照）
     target:self  // デリゲートのターゲットを指定
     action:@selector(showMenu)  // ボタンが押されたときに呼ばれるメソッドを指定
     ];
    self.navigationItem.leftBarButtonItem = btn;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"MENU" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.title = @"IT";
    self.navigationItem.titleView.backgroundColor = [UIColor colorWithRed:0.30 green:0.70 blue:0.00 alpha:0.1];
}
- (IBAction)showMenu {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// tableViewのセルの高さを返すデリゲートメソッド
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO 最下段だけ2px増やすように
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *theSection = tableDataList[section];
    NSArray *theData = theSection[@"data"];
    return theData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *theSection = tableDataList[indexPath.section];
    
    NSArray *theData = theSection[@"data"];
    
    ArticleListCustomCell *cell = (ArticleListCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"ArticleListCell"];
    if (cell == nil) {// create cell
        cell = [[[ArticleListCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ArticleListCell"]init];
    }
    NSDictionary *myData = theData[indexPath.row];
    
    
    cell.favicon.image = [self faviconImageFromUrl:myData[@"url"]];
    [cell.users setText:myData[@"usersCount"]];
    [cell.date setText:myData[@"postDate"]];
    NSString *tagFirst = myData[@"tags"][0];
    [cell.tags setText:tagFirst];
    [cell.title setText:myData[@"title"]];

    return cell;
}

- (UIImage*) faviconImageFromUrl:(NSString*) url
{
    NSString* baseUrl = @"http://favicon.hatena.ne.jp/?url=";
    NSString* path = [baseUrl stringByAppendingString:url];
    NSURL* accessUrl = [NSURL URLWithString:path];
    NSData* data = [NSData dataWithContentsOfURL:accessUrl];
    UIImage* img = [[UIImage alloc] initWithData:data];
    return img;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
    }];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = _indexPath;
        
        NSDictionary *theSection = tableDataList[indexPath.section];
        
        NSArray *theData = theSection[@"data"];
        
        NSDictionary *theCell = theData[indexPath.row];
        
        NSString *url = theCell[@"url"];
        NSString *title = theCell[@"title"];
        
        NSDictionary *param = @{
                                @"url" : url,
                                @"title" : title
                                };
        
        [[segue destinationViewController] setDetailItem:param];
    }
}

@end
