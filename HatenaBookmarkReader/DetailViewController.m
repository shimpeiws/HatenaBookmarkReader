//
//  DetailViewController.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/29.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    self.navigationItem.title = [_detailItem objectForKey:@"title"];

    if (self.detailItem) {
        NSURL *url = [NSURL URLWithString:[_detailItem objectForKey:@"url"]];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_myWebView loadRequest:urlRequest];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
