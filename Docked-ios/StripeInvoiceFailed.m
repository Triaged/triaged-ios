//
//  StripeInvoiceFailed.m
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "StripeInvoiceFailed.h"

@implementation StripeInvoiceFailed

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"amount": @"amount",
                               @"message": @"description",
                               @"customerEmail": @"customer_email",
                               };
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}

+ (Class)classForDeserializingManagedObject:(NSManagedObject *)managedObject {
    return StripeInvoiceFailed.class;
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

@end
