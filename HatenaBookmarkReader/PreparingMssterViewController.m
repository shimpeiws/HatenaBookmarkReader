//
//  PreparingMssterViewController.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2014/01/07.
//  Copyright (c) 2014年 shimpeiws. All rights reserved.
//

#import "PreparingMssterViewController.h"
#import "MasterViewController.h"
#import "MenuViewController.h"

@interface PreparingMssterViewController ()

@end

@implementation PreparingMssterViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MasterViewController *centerController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    MenuViewController *leftController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    
    
    self = [super initWithCenterViewController:centerController
                            leftViewController:leftController];
    
    self.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    self.viewDeckController.bounceOpenSideDurationFactor = 0.3f;
    
    if (self) {
        // Add any extra init code here
    }
    return self;
}

@end
