//
//  APIDetailViewController.h
//  CrowdtiltTest
//
//  Created by WM on 1/15/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMServerManager.h"

@interface APIDetailViewController : UIViewController <WMCrowdTiltDelegateProtocol, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

- (id)initWithAPICall:(NSString *)callString;

@end
