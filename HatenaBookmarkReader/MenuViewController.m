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

@interface MenuViewController ()

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupNabigationBar];
    [self setupMenu];
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
    MenuButton *categoryButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:3 labelString:@"カテゴリー"];
    MenuButton *tagButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:4 labelString:@"タグ"];
    MenuButton *settingButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:5 labelString:@"設定"];
    
    NSMutableArray *buttons = [NSMutableArray arrayWithObjects:favoriteButton, hotEntryButton, bookMarkButton, categoryButton, tagButton, settingButton, nil];
    for (MenuButton *myButton in buttons) {
        [self.view addSubview:myButton];
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
            UITableViewController* cc = (UITableViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = @"favorite";
            [cc.tableView reloadData];
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
        }

    }];
}

@end
