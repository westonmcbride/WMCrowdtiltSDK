//
//  Campaign.m
//  CrowdtiltTest
//
//  Created by WM on 1/6/13.
//  Copyright (c) 2013 WM. All rights reserved.
//

#import "Campaign.h"

@implementation Campaign

@dynamic title;
@dynamic createdAt;

- (BOOL)isCompleted
{
	return self.createdAt != nil;
}

- (void)setCompleted:(BOOL)completed
{
	self.createdAt = completed ? [NSDate date] : nil;
}

@end
