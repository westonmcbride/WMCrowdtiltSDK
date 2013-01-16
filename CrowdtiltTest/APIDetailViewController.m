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
@property NSArray *resultsArray;
@property NSString *cellTitleText;

@end

@implementation APIDetailViewController

@synthesize APIString;
@synthesize resultsArray;
@synthesize cellTitleText;

- (id)initWithAPICall:(NSString *)callString
{
    self = [super init];
    if (self) {
		self.APIString = callString;
		[self callServerWithString:callString];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = APIString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callServerWithString:(NSString *)callString
{
	if ([callString isEqualToString:@"/users GET"]) // temp temp temp
	{
		self.cellTitleText = @"firstname";
		[[WMServerManager getServerManager] getUsersWithDelegate:self];
	}
	if ([callString isEqualToString:@"/campaigns GET"]) // temp temp temp
	{
		self.cellTitleText = @"title";
		[[WMServerManager getServerManager] getCampaignsWithDelegate:self];
	}
}

#pragma mark - Crowdtilt delegate methods
- (void)updateCampaignArrayWithArray:(NSArray *)array
{
	self.resultsArray = array;
	[self.tableView reloadData];
}

- (void)updateUserArrayWithArray:(NSArray *)array
{
	self.resultsArray = array;
	[self.tableView reloadData];
}

- (void)returnSuccessfulPOSTWithRequest:(NSDictionary *)dict
{
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.contentView.backgroundColor = self.tableView.backgroundColor;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
		cell.textLabel.textColor = [UIColor darkGrayColor];
		cell.textLabel.backgroundColor = cell.contentView.backgroundColor;
		cell.detailTextLabel.backgroundColor = cell.textLabel.backgroundColor;
    }
	
	NSDictionary *resultsDict = [resultsArray objectAtIndex:indexPath.row];
	cell.textLabel.text = [resultsDict objectForKey:cellTitleText];
	cell.detailTextLabel.text = [resultsDict objectForKey:@"creation_date"];
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    return cell;
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

@end
