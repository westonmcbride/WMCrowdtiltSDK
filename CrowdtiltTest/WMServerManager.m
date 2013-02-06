//
//  WMServerManager.m
//  CrowdtiltTest
//
//  Created by WM on 12/20/12.
//  Copyright (c) 2012 WM. All rights reserved.
//

#import "WMServerManager.h"

@interface WMServerManager ()

@property (nonatomic, strong) NSObject <WMCrowdTiltDelegateProtocol> *tiltDelegate;
- (void)errorAlertWithError:(NSError *)error;

@end

static WMServerManager *serverManager;

@implementation WMServerManager

@synthesize tiltDelegate;

#pragma mark - Singleton setup
+ (WMServerManager *)getServerManager
{
	if(!serverManager) serverManager = [[WMServerManager alloc] init];
	return serverManager;
}

///////////////////
#pragma mark - POST

/*
 $ curl -X POST -H Content-Type:application/json \
 -u key:secret https://api-sandbox.crowdtilt.com/v1/users \
 -d'
 {
	 "user" : {
		 "firstname" : "foo",
		 "lastname" : "bar",
		 "email" : "user@example.com"
	 }
 }'
*/
- (void)postUserWithDict:(NSDictionary *)dict
{
	// Wrap a dictionary to contain the post dictionary:
	NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:dict, @"user", nil];
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:@"users" parameters:userDict
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[self serverRespondedWithDict:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
		[self errorAlertWithError:error];
	}];
	
}

/*
 Example campaign:
 "campaign" : {
	 "user_id" : "USRC55",
	 "expiration_date" : "2012-10-31T12:00:00Z",
	 "title" : "Halloween Awesome Fest",
	 "description" : "This will be the best thing ever!",
	 "tilt_amount" : 300000
 }
*/
- (void)postCampaignWithDict:(NSDictionary *)dict
{
	// Wrap a dictionary to contain the post dictionary:
	NSDictionary *campaignDict = [NSDictionary dictionaryWithObjectsAndKeys:dict, @"campaign", nil];
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:@"campaigns" parameters:campaignDict
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[self serverRespondedWithDict:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
		[self errorAlertWithError:error];
	}];
}

/*
 Example Card (NOTE: need a user ID to pass along as well)
 "card" : {
	 "number" : "4111111111111111",
	 "expiration_month" : "07",
	 "expiration_year" : "2032",
	 "security_code" : "123"
 }
*/
- (void)postUserCardWithDict:(NSDictionary *)dict
{
	NSString *userId = [dict objectForKey:@"user_id"];
	
	// TEMP
	// remove the user_id from the dictionary // this is way temp, in the future we'll just store the USER_ID in a user object.
	NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
	[mutableDict removeObjectForKey:@"user_id"];

	// Wrap a dictionary to contain the post dictionary:
	NSDictionary *cardDict = [NSDictionary dictionaryWithObjectsAndKeys:mutableDict, @"card", nil];
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:[NSString stringWithFormat:@"users/%@/cards", userId] parameters:cardDict
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[self serverRespondedWithDict:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
		[self errorAlertWithError:error];
	}];
}

/*
 Example Payment (NOTE: need a campaign ID)
 http://api.crowdtilt.com/v1/campaings/CMP542/payments \
 -d'{
	 "payment" : {
		 "user_id" : "USRE32",
		 "amount" : "2000",
		 "user_fee_amount" : "100",
		 "admin_fee_amount" : "200",
		 "card_id" : "CCPA69" // mine: CCPCA3C706270A911E29AD7ABD956AC4F1A
	 }
 }'
*/
- (void)postCampaignPaymentWithDict:(NSDictionary *)dict
{
	NSString *campaignId = [dict objectForKey:@"campaign_id"];
	
	// TEMP
	// remove the user_id from the dictionary // this is way temp, in the future we'll just store the USER_ID in a user object.
	NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
	[mutableDict removeObjectForKey:@"campaign_id"];
	
	// Wrap a dictionary to contain the post dictionary:
	NSDictionary *cardDict = [NSDictionary dictionaryWithObjectsAndKeys:mutableDict, @"payment", nil];
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:[NSString stringWithFormat:@"campaigns/%@/payments", campaignId] parameters:cardDict
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[self serverRespondedWithDict:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
		[self errorAlertWithError:error];
	}];
}



//////////////////
#pragma mark - GET

- (void)getUsersWithDelegate:(NSObject<WMCrowdTiltDelegateProtocol> *)delegate
{
	self.tiltDelegate = delegate;
	[[CrowdtiltTestAPIClient sharedClient] getPath:@"users" parameters:nil
										   success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[tiltDelegate updateUserArrayWithArray:[responseObject objectForKey:@"users"]];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
		[self errorAlertWithError:error];
	}];
}

- (void)getCampaignsWithDelegate:(NSObject<WMCrowdTiltDelegateProtocol> *)delegate
{
	self.tiltDelegate = delegate;
	[[CrowdtiltTestAPIClient sharedClient] getPath:@"campaigns" parameters:nil
										   success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[tiltDelegate updateCampaignArrayWithArray:[responseObject objectForKey:@"campaigns"]];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
		[self errorAlertWithError:error];
	}];
}


#pragma mark - General response handler
- (void)serverRespondedWithDict:(NSDictionary *)dict
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your request didn't fail!" delegate:self cancelButtonTitle:@"Far out!" otherButtonTitles:nil];
	[alert show];
	
	// update Core Data model.
	// update view controllers
}

- (void)errorAlertWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Doh!" message:[NSString stringWithFormat:@"Your request failed because: %@!", error] delegate:self cancelButtonTitle:@"Bummer city!" otherButtonTitles:nil];
	[alert show];

	// triage
	// update models and controllers
}


@end
