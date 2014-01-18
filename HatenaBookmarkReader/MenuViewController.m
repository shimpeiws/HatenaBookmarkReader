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
    MenuButton *menuButton = [[MenuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30) columNum:1 labelString:@"world"];
    [self.view addSubview:menuButton];
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

@end
