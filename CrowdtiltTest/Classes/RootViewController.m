//
//  RootViewController.m
//  CrowdtiltTest
//
//  Created by WM on 1/6/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property NSDictionary *APIDict;

@end

@implementation RootViewController

@synthesize APIDict;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Crowdtilt API";
	
	NSArray *userAPI = [NSArray arrayWithObjects:
						@"/users GET",
						nil];
		
	NSArray *campaignAPI = [NSArray arrayWithObjects:
						@"/campaigns GET",
						nil];
	
	self.APIDict = [NSDictionary dictionaryWithObjectsAndKeys:
							 userAPI, @"/user",
							 campaignAPI, @"/campaign",
							 nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.APIDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *string = [[self.APIDict allKeys] objectAtIndex:section];
	NSArray *array = [self.APIDict objectForKey:string];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *string = [[self.APIDict allKeys] objectAtIndex:section];
	return string;
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
	
	NSString *string = [[self.APIDict allKeys] objectAtIndex:indexPath.section];
	NSArray *array = [self.APIDict objectForKey:string];
	cell.textLabel.text = [array objectAtIndex:indexPath.row];
	
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *string = [[self.APIDict allKeys] objectAtIndex:indexPath.section];
	NSArray *array = [self.APIDict objectForKey:string];
	NSString *selectedAPICall = [array objectAtIndex:indexPath.row];
	
	APIDetailViewController *detailVC = [[APIDetailViewController alloc] initWithAPICall:selectedAPICall];
	[self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate



//// Demo JSON request:
//	NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=Apple"];
//	NSURLRequest *request = [NSURLRequest requestWithURL:url];
//	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//										success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
//	{
//		NSLog(@"response: %@", JSON);
//		resultsArray = [JSON objectForKey:@"results"];
//		[self.tableView reloadData];
//	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//		NSLog(@"%@", error);
//	}];
//
//	[operation start];


//// Core data business: 
//	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Campaign"];
//	fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO]];

//	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//	self.fetchedResultsController.delegate = self;
//	[self.fetchedResultsController performFetch:nil];


@end
