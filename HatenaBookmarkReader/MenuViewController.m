//
//  MenuViewController.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/05.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import "MenuViewController.h"
#import "IIViewDeckController.h"
#import "MenuButton.h"
#import "MasterViewController.h"
#import "CategoryTableViewController.h"

@interface MenuViewController ()
{
    UIScrollView *scrollView;
    UIView *subView;
    CategoryTableViewController *categoryTable;
    BOOL categoriesOpenFlag;
}

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    categoriesOpenFlag = FALSE;
    categoryTable = [[CategoryTableViewController alloc]init];
    categoryTable.delegate = self;
    
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.scrollEnabled = YES;
//    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
//    subView = [[UIView init] alloc];
//    [scrollView addSubview:subView];
    
	// Do any additional setup after loading the view.
    [self setupNabigationBar];
    [self setupMenu];
}

-(void)viewDidLayoutSubviews {
    [scrollView setContentSize: self.view.bounds.size];
    [scrollView flashScrollIndicators];
}

- (void)setupNabigationBar
{
    UINavigationController *navigationController = self.navigationController;
    navigationController.navigationBarHidden = YES;
}

- (void)setupMenu {
    MenuButton *favoriteButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:0 labelString:@"お気に入り"];
    [favoriteButton addTarget:self action:@selector(favoriteButtonSelected:)  forControlEvents:UIControlEventTouchUpInside];
    MenuButton *hotEntryButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:1 labelString:@"マイホットエントリー"];
    MenuButton *bookMarkButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:2 labelString:@"ブックマーク"];
    [bookMarkButton addTarget:self action:@selector(bookMarkButtonSelected:)  forControlEvents:UIControlEventTouchUpInside];
    MenuButton *categoryButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:3 labelString:@"カテゴリー"];
    [categoryButton addTarget:self action:@selector(categoryButtonSelected:)  forControlEvents:UIControlEventTouchUpInside];
    MenuButton *tagButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:4 labelString:@"タグ"];
    MenuButton *settingButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:5 labelString:@"設定"];
    
    NSMutableArray *buttons = [NSMutableArray arrayWithObjects:favoriteButton, hotEntryButton, bookMarkButton, categoryButton, tagButton, settingButton, nil];
    for (MenuButton *myButton in buttons) {
        [self.view addSubview:myButton];
//        [scrollView addSubview:myButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        // メインビュー側での処理等を行う
    }];
}

-(void)favoriteButtonSelected:(id)inSender {
	NSLog(@"favoriteButtonTapped");
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            MasterViewController* cc = (MasterViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = @"お気に入り";
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
            [cc getFavorieItems];
        }

    }];
}

-(void)bookMarkButtonSelected:(id)inSender {
    NSLog(@"favoriteButtonTapped");
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            MasterViewController* cc = (MasterViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = @"ブックマーク";
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
            [cc getBookmarkedItems];
        }
        
    }];
}

- (void) categotySelected: (NSInteger) selectedRow {
    NSLog(@"カテゴリーID %d tappped", selectedRow);
    NSString *title = @"";
    switch (selectedRow) {
        case 0:
            title = @"世の中";
            break;
        case 1:
            title = @"政治と経済";
            break;
        case 2:
            title = @"暮らし";
            break;
        case 3:
            title = @"学び";
            break;
        case 4:
            title = @"テクノロジー";
            break;
        case 5:
            title = @"エンタメ";
            break;
        case 6:
            title = @"アニメとゲーム";
            break;
        case 7:
            title = @"おもしろ";
            break;
        case 8:
            title = @"動画";
            break;
            
        default:
            break;
    }
    
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            MasterViewController* cc = (MasterViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = title;
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
            [cc getCategoryItems:selectedRow];
        }
        
    }];

}

-(void)categoryButtonSelected:(id)inSender {
    
    
    NSArray* subviews = self.view.subviews;
    MenuButton *categoryButton = (MenuButton*)subviews[6];
    
    if (categoriesOpenFlag) {
        [subviews[9] removeFromSuperview];
        
    } else {
        categoryTable.tableView.frame = CGRectMake(0, categoryButton.frame.origin.y + 50, 300, 300);
        categoryTable.tableView.scrollEnabled = NO;
        [self.view addSubview:categoryTable.tableView];
        [self.view bringSubviewToFront:categoryTable.view];
    }
    [self animateButton];
    categoriesOpenFlag = !categoriesOpenFlag;
}

-(void) animateButton
{
    NSArray* subviews = self.view.subviews;
    MenuButton *tagButton = (MenuButton*)subviews[7];
    MenuButton *settingButton = (MenuButton*)subviews[8];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if(categoriesOpenFlag) {
        tagButton.center = CGPointMake(20, 370);
        settingButton.center = CGPointMake(20, 435);
    } else {
        tagButton.center = CGPointMake(20, 800);
        settingButton.center = CGPointMake(20, 1000);
    }
    [UIView commitAnimations];
}

@end
