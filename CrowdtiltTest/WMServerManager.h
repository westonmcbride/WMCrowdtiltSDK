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

#warning Weston - notes:
/*
 - finish adding all the server calls
 - add custom objects to the various calls
 - hook up server responses for non-delegate methods
*/
 
// POST methods with dictionaries
// * User
- (void)postUserWithDict:(NSDictionary *)dict; // complete
- (void)postUserVerificationWithDict:(NSDictionary *)dict;
- (void)getUserAuthenticationWithDict:(NSDictionary *)dict;
- (void)postUserCardWithDict:(NSDictionary *)dict; // complete
- (void)postUserBankWithDict:(NSDictionary *)dict;
// * Campaign
- (void)postCampaignWithDict:(NSDictionary *)dict; // complete
- (void)postCampaignPaymentWithDict:(NSDictionary *)dict; // complete
- (void)postCampaignRefundWithDict:(NSDictionary *)dict;
- (void)postCampaignCommentWithDict:(NSDictionary *)dict;

// PUT methods with dictionaries (and probably need delegates to refresh custom objects)??
// * User
- (void)putUserWithDict:(NSDictionary *)dict;
- (void)putUserCardWithDict:(NSDictionary *)dict;
- (void)putUserBankWithDict:(NSDictionary *)dict;
// * Campaign
- (void)putCampaignWithDict:(NSDictionary *)dict;
- (void)putCampaignPaymentWithDict:(NSDictionary *)dict;
- (void)putCampaignSettlementBankWithDict:(NSDictionary *)dict;
- (void)putCampaignCommentWithDict:(NSDictionary *)dict;

// GET methods complete with delegates to refresh View Controllers
// * User
- (void)getUsersWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getSingleUserWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate; // complete
- (void)getUserCampaignsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserSingleCampaignWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserPaidCampaignsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserSingleCardWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserCardsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserSingleBankWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserBanksWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getUserPaymentsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;

// * Campaign
- (void)getCampaignsWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getSingleCampaignWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate; // complete
- (void)getCampaignSinglePaymentWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignPaymentsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignRejectedPaymentsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignSettlementsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignSingleSettlementWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignCommentsWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;
- (void)getCampaignSingleCommentWithDict:(NSDictionary *)dict andWithDelegate:(NSObject <WMCrowdTiltDelegateProtocol>*)delegate;

// DELETE methods
- (void)deleteUserCardWithDict:(NSDictionary *)dict;
- (void)deleteUserBankWithDict:(NSDictionary *)dict;
- (void)deleteCampaignCommentWithDict:(NSDictionary *)dict;

@end
