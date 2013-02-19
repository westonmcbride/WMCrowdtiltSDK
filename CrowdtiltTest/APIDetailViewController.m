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
@property NSMutableDictionary *textEntryDict;

@property UITableView *resultsTableView;
@property UITextView *resultsTextView;
@property BOOL tableBOOL;

@end

@implementation APIDetailViewController

@synthesize APIString;
@synthesize resultsArray;
@synthesize cellTitleText;
@synthesize textEntryDict;

@synthesize resultsTableView;
@synthesize resultsTextView;
@synthesize tableBOOL;

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
	
	self.title = APIString;
	
	[self callServerWithString:APIString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Variable View Setup Methods
- (void)setupTableView
{
	self.resultsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	resultsTableView.delegate = self;
	resultsTableView.dataSource = self;
	[self.view addSubview:resultsTableView];
	self.tableBOOL = YES;
}

//- (void)setupTextView
//{
//	self.resultsTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
//	[self.view addSubview:resultsTextView];
//	self.tableBOOL = NO;
//}

- (void)setupTextEntryWithDict:(NSDictionary *)dict
{
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendTextToServer)];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//	scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 2); // put in some logic to extend the content
//	scrollView.contentSize = [scrollView sizeThatFits:scrollView.contentSize]; // only if the content size is greater than the scrollview bounds
	scrollView.backgroundColor = [UIColor whiteColor];
	
	self.textEntryDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
	
	NSMutableDictionary *mutableKeysDict = [[NSMutableDictionary alloc] initWithDictionary:textEntryDict];
	[mutableKeysDict removeObjectForKey:@"callString"];
	
	NSArray *dictKeys = [mutableKeysDict allKeys];
	int i = 0;
	for (NSString *key in dictKeys)
	{
		UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
		textField.backgroundColor = [UIColor whiteColor];
		textField.center = CGPointMake(self.view.center.x, 20 + (i * 35));
		textField.placeholder = key;
		textField.delegate = self;
		textField.tag = i;
		if([key isEqualToString:@"email"]) textField.keyboardType = UIKeyboardTypeEmailAddress;
		[scrollView addSubview:textField];
		i++;
	}
	
	[self.view addSubview:scrollView];
}


#pragma mark - API interaction method
- (void)callServerWithString:(NSString *)callString
{
	if ([callString isEqualToString:@"/users GET"]) // temp temp temp
	{
		self.cellTitleText = @"firstname";
		[self setupTableView];
		[[WMServerManager getServerManager] getUsersWithDelegate:self];
	}
	if ([callString isEqualToString:@"/users POST"]) // temp temp temp
	{
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  callString ,@"callString",
							  @"john", @"firstname",
							  @"doe", @"lastname",
							  @"john@doe.com", @"email",
							  nil];
		
		[self setupTextEntryWithDict:dict];		
	}
	if ([callString isEqualToString:@"/users/:id/cards POST"]) // temp temp temp
	{
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  callString ,@"callString",
							  @"2032", @"expiration_year",
							  @"123", @"security_code",
							  @"07", @"expiration_month",
							  @"4111111111111111", @"number",
							  nil];
		
		[self setupTextEntryWithDict:dict];
	}
	if ([callString isEqualToString:@"/campaigns GET"]) // temp temp temp
	{
		self.cellTitleText = @"title";
		[self setupTableView];
		[[WMServerManager getServerManager] getCampaignsWithDelegate:self];
	}
	if ([callString isEqualToString:@"/campaigns POST"]) // temp temp temp
	{
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  callString ,@"callString",
							  @"super happy one dollar party", @"title",
							  @"the name says it all", @"description",
							  @"100", @"tilt_amount",
							  nil];
		
		[self setupTextEntryWithDict:dict];
	}
	if ([callString isEqualToString:@"/campaigns/:id/payments POST"]) // temp temp temp
	{
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  callString ,@"callString",
							  @"400", @"amount",
							  nil];
		
		[self setupTextEntryWithDict:dict];
	}

}

// Compiles user-entered text and readies the server request.
- (void)sendTextToServer
{
	if([[textEntryDict objectForKey:@"callString"] isEqualToString:@"/users POST"])
	{
		[textEntryDict removeObjectForKey:@"callString"];
		[[WMServerManager getServerManager] postUserWithDict:textEntryDict];
	}
	else if([[textEntryDict objectForKey:@"callString"] isEqualToString:@"/users/:id/cards POST"])
	{
		[textEntryDict removeObjectForKey:@"callString"];
		[textEntryDict setObject:@"USRC550375E4A0D11E2BAA9A0490208FF4A" forKey:@"user_id"]; // TEMP
		[[WMServerManager getServerManager] postUserCardWithDict:textEntryDict];
	}
	else if([[textEntryDict objectForKey:@"callString"] isEqualToString:@"/campaigns POST"])
	{
		[textEntryDict removeObjectForKey:@"callString"];
		[textEntryDict setObject:@"USRC550375E4A0D11E2BAA9A0490208FF4A" forKey:@"user_id"];	// TEMP
		[textEntryDict setObject:@"2014-01-02T01:02:03Z" forKey:@"expiration_date"];
		[[WMServerManager getServerManager] postCampaignWithDict:textEntryDict];
	}
	else if([[textEntryDict objectForKey:@"callString"] isEqualToString:@"/campaigns/:id/payments POST"])
	{
		[textEntryDict removeObjectForKey:@"callString"];
		
		// TEMP - these Id's are obvi temporarily hardcoded.
		[textEntryDict setObject:@"USRC550375E4A0D11E2BAA9A0490208FF4A" forKey:@"user_id"];
		[textEntryDict setObject:@"CMPC8A708EC584A11E2948FFDCF3550B882" forKey:@"campaign_id"];
		[textEntryDict setObject:@"CCPCA3C706270A911E29AD7ABD956AC4F1A" forKey:@"card_id"];
		
		int amount = [[textEntryDict objectForKey:@"amount"] intValue];
		int userFee = (amount * 0.025);
		[textEntryDict setObject:[NSString stringWithFormat:@"%i", userFee] forKey:@"user_fee_amount"];
		int adminFee = (amount * 0.035);
		[textEntryDict setObject:[NSString stringWithFormat:@"%i", adminFee] forKey:@"admin_fee_amount"];
		
		[[WMServerManager getServerManager] postCampaignPaymentWithDict:textEntryDict];
	}	
}

//#pragma mark - UIAlertView delegate methods
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	// If the email was posted. 
//	if([[alertView title] isEqualToString:@"Please enter your email."])
//	{
//		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//							  @"captain", @"firstname",
//							  @"kangaroo", @"lastname",
//							  [alertView textFieldAtIndex:0].text, @"email",
//							  nil];
//		[[WMServerManager getServerManager] postUserWithDict:dict];
//	}
//}

#pragma mark - Crowdtilt delegate methods
- (void)updateCampaignArrayWithArray:(NSArray *)array
{
	self.resultsArray = array;
	if(tableBOOL == YES)
		[resultsTableView reloadData];
}

- (void)updateUserArrayWithArray:(NSArray *)array
{
	self.resultsArray = array;
	if(tableBOOL == YES)
		[resultsTableView reloadData];
}

- (void)returnSuccessfulPOSTWithRequest:(NSDictionary *)dict
{
	// 
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
		cell.contentView.backgroundColor = resultsTableView.backgroundColor;
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


#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[textEntryDict setObject:textField.text forKey:textField.placeholder];
}

@end
