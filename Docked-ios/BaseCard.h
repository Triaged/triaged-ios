//
//  BaseCard.h
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLFeedItem.h"
#import "Provider.h"

@interface BaseCard : MTLFeedItem <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *event;
@property (nonatomic, copy, readonly) Provider *provider;

+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths;


@end