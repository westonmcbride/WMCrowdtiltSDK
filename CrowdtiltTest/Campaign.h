//
//  Campaign.h
//  CrowdtiltTest
//
//  Created by WM on 1/6/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Campaign : NSManagedObject

@property NSString *title;
@property NSDate *createdAt;

@property (nonatomic, getter = isCompleted) BOOL completed;

@end
