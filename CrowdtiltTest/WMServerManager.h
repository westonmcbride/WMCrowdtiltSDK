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

@interface WMServerManager : NSObject

+ (WMServerManager *)getServerManager;

- (void)callServerWithParameters:(NSDictionary *)parameterDict;

@end
