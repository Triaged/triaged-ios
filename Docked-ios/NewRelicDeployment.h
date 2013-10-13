//
//  Deployment.h
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface NewRelicDeployment : FeedItem

@property (nonatomic, copy, readonly) NSString *applicationName;
@property (nonatomic, copy, readonly) NSString *accountName;
@property (nonatomic, copy, readonly) NSString *changelog;
@property (nonatomic, copy, readonly) NSString *description;
@property (nonatomic, copy, readonly) NSString *revision;
@property (nonatomic, copy, readonly) NSString *deployedBy;

@end
