//
//  StripeChargeSucceeded.m
//  Docked-ios
//
//  Created by Charlie White on 9/24/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "StripeChargeSucceeded.h"

@implementation StripeChargeSucceeded

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"externalID": @"id",
             @"amount": @"amount",
             @"description": @"description",
             @"customerEmail": @"customer_email",
             @"htmlUrl": @"html_url",
             @"messages": @"messages",
             @"timestamp": @"timestamp"
             };
}

-(NSString*)property {
    return @"Docked.com";
}

-(NSString*)action {
    return @"Charge Succeeded";
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

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"stripe.png"];
}

@end
