//
//  StripeDisputeCreated.m
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "StripeDisputeCreated.h"

@implementation StripeDisputeCreated

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"amount": @"amount",
                               @"descrip": @"description",
                               @"customerEmail": @"customer_email",
                               };
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}

+ (Class)classForDeserializingManagedObject:(NSManagedObject *)managedObject {
    return StripeDisputeCreated.class;
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}


@end
