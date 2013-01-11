//
//  RootViewController.m
//  CrowdtiltTest
//
//  Created by WM on 1/6/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import "RootViewController.h"
#import "CrowdtiltTestAPIClient.h"

@interface RootViewController () <NSFetchedResultsControllerDelegate>

@property NSFetchedResultsController *fetchedResultsController;
@property NSString *cellTitleText; 

@property NSArray *resultsArray;

@end

@implementation RootViewController

@synthesize resultsArray;
@synthesize cellTitleText;

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
	
	self.title = @"tweets";
	
	self.cellTitleText = @"title";
	
	[[WMServerManager getServerManager] getCampaignsWithDelegate:self];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postCampaign)];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Users" style:UIBarButtonItemStyleBordered target:self action:@selector(switchToUser)];
		
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchToUser
{
	[[WMServerManager getServerManager] getUsersWithDelegate:self];
	
	self.cellTitleText = @"firstname";	
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsArray.count;
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
	
	NSDictionary *campaign = [self.resultsArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [campaign objectForKey:cellTitleText];
	cell.detailTextLabel.text = [campaign objectForKey:@"creation_date"];
	
//	NSString *imageURL = [campaign objectForKey:@"img"];
//	[cell.imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"bobafacebook.jpg"]];
	
//	[self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [managedObject valueForKey:@"title"];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]    withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]    withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)object
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]     withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]    withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] forRowAtIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]    withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]     withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


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
