//
//  MTLGraphDataDetail.m
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLGraphDataDetail.h"

@implementation MTLGraphDataDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"x": @"x",
                               @"y": @"y",
                               @"index" : @"index"
                            };
    
    return jsonKeys;
}

+ (NSString *)managedObjectEntityName {
    return @"GraphDataDetail";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
