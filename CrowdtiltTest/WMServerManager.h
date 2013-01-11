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

- (void)postUserWithDict:(NSDictionary *)dict;
- (void)postCampaignWithDict:(NSDictionary *)dict;

- (void)getUsersWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignsWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;

@end
