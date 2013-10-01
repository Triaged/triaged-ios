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
             @"amount": @"amount"
             };
}

-(NSString*)titleLabel {
    return @"Charge Succeeded";
}

-(NSString *)bodyLabel {
    return [NSString stringWithFormat:@"Successful charge of $%@", self.amount];
}

-(UIImage *)icon {
    UIImage *icon = [UIImage imageNamed:@"stripe.png"];
    return icon;
}

@end
