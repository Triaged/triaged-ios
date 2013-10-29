//
//  GraphItem.m
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLGraphItem.h"
#import "MTLGraphDataSet.h"

@implementation MTLGraphItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"body": @"body",
                               @"dataSets": @"data_sets"
                               };
    
    return [MTLFeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSValueTransformer *)dataSetsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLGraphDataSet class]];
}


+ (NSString *)managedObjectEntityName {
    return @"GraphItem";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{@"dataSets" : MTLGraphDataSet.class};
}




@end
