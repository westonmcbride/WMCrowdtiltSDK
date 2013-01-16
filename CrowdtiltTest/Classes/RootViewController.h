//
//  RootViewController.h
//  CrowdtiltTest
//
//  Created by WM on 1/6/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "WMServerManager.h"
#import "APIDetailViewController.h"

@interface RootViewController : UITableViewController <WMCrowdTiltDelegateProtocol>

@property NSManagedObjectContext *managedObjectContext;

@end
