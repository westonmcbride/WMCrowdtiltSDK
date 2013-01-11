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


- (void)postUserWithDict:(NSDictionary *)dict
{	
	NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:dict, @"user", nil];
	
//	NSLog(@"%@", userDict);
// user dict:
//	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//						  @"USRC550375E4A0D11E2BAA9A0490208FF4A", @"user_id",
//						  @"TestCamp2", @"title",
//						  @"testytestagain", @"description",
//						  @"2000-01-02T01:02:03Z", @"expiration_date",
//						  @"1000", @"tilt_amount",
//						  nil];
	
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:@"users" parameters:userDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[self serverRespondedWithDict:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
	}];
	
}

- (void)postCampaignWithDict:(NSDictionary *)dict
{
	NSDictionary *campaignDict = [NSDictionary dictionaryWithObjectsAndKeys:dict, @"campaign", nil];
	
	//	NSLog(@"%@", userDict);
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:@"campaigns" parameters:campaignDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[self serverRespondedWithDict:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
	}];
}

- (void)getUsersWithDelegate:(NSObject<WMCrowdTiltDelegateProtocol> *)delegate
{
	self.tiltDelegate = delegate;
	[[CrowdtiltTestAPIClient sharedClient] getPath:@"users" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[tiltDelegate updateUserArrayWithArray:[responseObject objectForKey:@"users"]];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
	}];
}

- (void)getCampaignsWithDelegate:(NSObject<WMCrowdTiltDelegateProtocol> *)delegate
{
	self.tiltDelegate = delegate;
	[[CrowdtiltTestAPIClient sharedClient] getPath:@"campaigns" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", responseObject); // call catcher method
		[tiltDelegate updateCampaignArrayWithArray:[responseObject objectForKey:@"campaigns"]];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
	}];
}


- (void)serverRespondedWithDict:(NSDictionary *)dict
{
	NSLog(@"still here!");
	
	// update Core Data model.
	// update view controllers
}


@end
