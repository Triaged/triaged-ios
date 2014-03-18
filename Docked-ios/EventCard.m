//
//  EventCard.m
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "EventCard.h"
#import "EventCardCell.h"


@implementation EventCard

@dynamic body;
@dynamic event;
@dynamic externalID;
@dynamic footer;
@dynamic propertyName;
@dynamic thumbnailUrl;
@dynamic title;
@dynamic url;

- (id)itemCellClass {
    return EventCardCell.class;
}

@end
