//
//  WMServerManager.h
//  CrowdtiltTest
//
//  Created by WM on 12/20/12.
//  Copyright (c) 2012 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrowdtiltTestAPIClient.h"
#import "JSON.h"

@protocol WMCrowdTiltDelegateProtocol <NSObject>

- (void)updateCampaignArrayWithArray:(NSArray *)array;
- (void)updateUserArrayWithArray:(NSArray *)array;
- (void)returnSuccessfulPOSTWithRequest:(NSDictionary *)dict;

@end

@interface WMServerManager : NSObject

+ (WMServerManager *)getServerManager;

// Post methods with dictionaries
- (void)postUserWithDict:(NSDictionary *)dict;
- (void)postCampaignWithDict:(NSDictionary *)dict;

// List getter methods complete with delegates to refresh View Controllers
- (void)getUsersWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignsWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;

@end
