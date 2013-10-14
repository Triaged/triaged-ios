//
//  StripeChargeRefunded.m
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "StripeChargeRefunded.h"

@implementation StripeChargeRefunded

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"amount": @"amount",
                               @"description": @"description",
                               @"customerEmail": @"customer_email",
                               };
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

-(NSString*)property {
    return @"Docked.com";
}

-(NSString*)action {
    return @"Charge Refunded";
}

-(NSString *)body {
    NSString *body = [NSString stringWithFormat:@"Amount: $%@\n", self.amount];
    
    if (self.description != nil) {
        body = [body stringByAppendingString:[NSString stringWithFormat:@"Description: %@\n", self.description]];
    }
    
    if (self.customerEmail != nil) {
        body = [body stringByAppendingString:[NSString stringWithFormat:@"Customer: %@", self.customerEmail]];
    }
    
    return body;
}


@end
