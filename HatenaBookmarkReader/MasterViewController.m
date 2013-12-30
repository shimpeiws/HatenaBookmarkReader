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
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    self.navigationItem.title = @"Hello";
    [self setupTableViewStyle];
    [self setupNavigationItem];
    [self setupItems];
}

- (void)setupItems
{
    NSDictionary *cell110 = @{@"title":@"ここに記事タイトル", @"url":@"http://example.com", @"icon":@"http://example.com", @"usersCount":@"1", @"postDate":@"2013", @"tags":@[@"ruby", @"security"]};
    NSDictionary *cell111 = @{@"title":@"ここに記事タイトル", @"url":@"http://example.com", @"icon":@"http://example.com", @"usersCount":@"1", @"postDate":@"2013", @"tags":@[@"ruby", @"security"]};
    NSDictionary *cell112 = @{@"title":@"ここに記事タイトル", @"url":@"http://example.com", @"icon":@"http://example.com", @"usersCount":@"1", @"postDate":@"2013", @"tags":@[@"ruby", @"security"]};
    NSDictionary *cell113 = @{@"title":@"ここに記事タイトル", @"url":@"http://example.com", @"icon":@"http://example.com", @"usersCount":@"1", @"postDate":@"2013", @"tags":@[@"ruby", @"security"]};
    NSDictionary *cell114 = @{@"title":@"ここに記事タイトル", @"url":@"http://example.com", @"icon":@"http://example.com", @"usersCount":@"1", @"postDate":@"2013", @"tags":@[@"ruby", @"security"]};
    
    NSDictionary *section = @{@"header":@"articles", @"data":@[cell110, cell111, cell112, cell113, cell114]};
    
    NSLog(@"section = %@", section);
    
    
    
    tableDataList = @[section];
                              

}

- (void)setupTableViewStyle
{
    self.tableView.separatorColor = [UIColor grayColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

}

- (void)setupNavigationItem
{
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Hello";
    self.navigationItem.titleView.backgroundColor = [UIColor colorWithRed:0.30 green:0.70 blue:0.00 alpha:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!tableDataList) {
//        _tableDataList = [[NSArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// tableViewのセルの高さを返すデリゲートメソッド
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *theSection = tableDataList[section];
    NSArray *theData = theSection[@"data"];
    return theData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *theSection = tableDataList[indexPath.section];
    
    NSArray *theData = theSection[@"data"];
    
    //NSDictionary *theCell = theData[indexPath.row];
//
//    NSLog(@"title = %@", theCell[@"title"]);
//    
//    cell.textLabel.text = theCell[@"title"];
    
    // call cell
    // call cell
    
    tableView.rowHeight = 50;
    ArticleListCustomCell *cell = (ArticleListCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"table_cell"];
    if (cell == nil) {// create cell
        cell = [[[ArticleListCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"table_cell"]init];
    }
    NSDictionary *myData = theData[indexPath.row];
    [cell.title setText:myData[@"title"]];

    return cell;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *theSection = tableDataList[indexPath.section];
        
        NSArray *theData = theSection[@"data"];
        
        NSDictionary *theCell = theData[indexPath.row];
        
        NSString *url = theCell[@"url"];
        
        [[segue destinationViewController] setDetailItem:url];
    }
}

@end
