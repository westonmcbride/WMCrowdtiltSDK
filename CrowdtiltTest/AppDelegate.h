//
//  AppDelegate.h
//  CrowdtiltTest
//
//  Created by WM on 12/18/12.
//  Copyright (c) 2012 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CrowdtiltTestIncrementalStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDelegate, NSURLConnectionDownloadDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
