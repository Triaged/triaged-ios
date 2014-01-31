//
//  EventCard.m
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "EventCard.h"
#import "EventCardCell.h"

@implementation EventCard


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"title" : @"title",
                               @"body": @"body",
                               @"footer": @"footer",
                               @"url": @"url",
                               @"externalID": @"external_id",
                               @"propertyName" : @"property_name",
                               @"thumbailUrl" : @"thumbnail_url",
                               @"imageUrl" : @"image_url"
                               };
    
    return [BaseCard JSONKeyPathsWithSuper:jsonKeys];
}

- (id)itemCellClass {
    return EventCardCell.class;
}

@end
