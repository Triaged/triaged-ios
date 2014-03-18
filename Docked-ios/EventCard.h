//
//  EventCard.h
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FeedItem.h"


@interface EventCard : FeedItem <FeedItemCellProtocol>

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSString * externalID;
@property (nonatomic, retain) NSString * footer;
@property (nonatomic, retain) NSString * propertyName;
@property (nonatomic, retain) NSString * thumbnailUrl;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;

@end
