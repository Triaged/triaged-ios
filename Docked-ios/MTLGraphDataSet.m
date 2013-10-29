//
//  MTLGraphDataSet.m
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLGraphDataSet.h"
#import "MTLGraphDataDetail.h"

@implementation MTLGraphDataSet

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"title": @"label",
                               @"totalDataCount": @"total_count",
                               @"maxYCount" : @"max_y_count",
                               @"dataDetails" : @"details"
                               };
    
    return jsonKeys;
}

+ (NSValueTransformer *)dataDetailsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLGraphDataDetail class]];
}

+ (NSString *)managedObjectEntityName {
    return @"GraphDataSet";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}


+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{@"dataDetails" : MTLGraphDataDetail.class, @"graphItem" : MTLGraphItem.class};
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
