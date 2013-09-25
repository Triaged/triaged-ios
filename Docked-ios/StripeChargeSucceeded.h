//
//  StripeChargeSucceeded.h
//  Docked-ios
//
//  Created by Charlie White on 9/24/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface StripeChargeSucceeded : FeedItem

@property (nonatomic, copy, readonly) NSString *serverID;
@property (nonatomic, copy, readonly) NSString *amount;


@end
