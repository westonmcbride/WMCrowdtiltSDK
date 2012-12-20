//
//  WMServerManager.m
//  CrowdtiltTest
//
//  Created by WM on 12/20/12.
//  Copyright (c) 2012 WM. All rights reserved.
//

#import "WMServerManager.h"

static WMServerManager *serverManager;

@implementation WMServerManager

#pragma mark - Singleton setup
+ (WMServerManager *)getServerManager
{
	if(!serverManager) serverManager = [[WMServerManager alloc] init];
	return serverManager;
}


- (void)callServerWithParameters:(NSDictionary *)parameterDict
{

	/////// temp
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  //						  @"user@example.com", @"email",
						  //						  @"mypassword", @"password",
						  @"foop", @"firstname",
						  @"barp", @"lastname",
						  @"foo123@bar123.com", @"email",
						  nil];
	
	NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:dict, @"user", nil];
	
	NSLog(@"%@", userDict);
	
	[[CrowdtiltTestAPIClient sharedClient] postPath:@"users" parameters:userDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"success: %@", [responseObject JSONRepresentation]); // call catcher method
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error: %@", error); // call failure catcher method
	}];
}


@end
