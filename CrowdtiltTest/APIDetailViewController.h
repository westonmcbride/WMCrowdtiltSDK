//
//  APIDetailViewController.h
//  CrowdtiltTest
//
//  Created by WM on 1/15/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMServerManager.h"

@interface APIDetailViewController : UITableViewController <WMCrowdTiltDelegateProtocol>

- (id)initWithAPICall:(NSString *)callString;

@end
