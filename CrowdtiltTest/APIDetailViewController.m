//
//  APIDetailViewController.m
//  CrowdtiltTest
//
//  Created by WM on 1/15/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import "APIDetailViewController.h"

@interface APIDetailViewController ()

@property NSString *APIString;

@end

@implementation APIDetailViewController

@synthesize APIString;

- (id)initWithAPICall:(NSString *)callString
{
    self = [super init];
    if (self) {
		self.APIString = callString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	self.cellTitleText = @"title";
//	
//	[[WMServerManager getServerManager] getCampaignsWithDelegate:self];
//	
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postCampaign)];
//	
//	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Users" style:UIBarButtonItemStyleBordered target:self action:@selector(switchToUser)];
//
//	// Do any additional setup after loading the view.
//}
//
//- (void)switchToUser
//{
//	[[WMServerManager getServerManager] getUsersWithDelegate:self];
//	
//	self.cellTitleText = @"firstname";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
