//
//  GoogleAnalyticsDailyStatus.h
//  Docked-ios
//
//  Created by Charlie White on 10/2/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "GoogleAnalyticsDailyStatusDetails.h"
#import "GraphDataCell.h"

@interface GoogleAnalyticsDailyStatus : FeedItem <GraphCardProtocol>

@property (nonatomic, copy, readonly) NSNumber *visitsSum;
@property (nonatomic, copy, readonly) NSNumber *visitorsSum;
@property (nonatomic, copy, readonly) NSNumber *pageViewsSum;
@property (nonatomic, copy, readonly) NSDate   *date;
@property (nonatomic, copy, readonly) NSArray  *dailyDetails;


@end
