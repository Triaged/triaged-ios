//
//  StripeEvent.h
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface StripeEvent : FeedItem

@property (nonatomic, copy, readonly) NSNumber *amount;
@property (nonatomic, copy, readonly) NSString *descrip;
@property (nonatomic, copy, readonly) NSString *customerEmail;

@end
