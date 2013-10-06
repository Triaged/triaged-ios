//
//  GoogleAnalyticsDailyStatusDetails.h
//  Docked-ios
//
//  Created by Charlie White on 10/2/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface GoogleAnalyticsDailyStatusDetails : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *visitsCount;
@property (nonatomic, copy, readonly) NSNumber *visitorsCount;
@property (nonatomic, copy, readonly) NSNumber *pageViewsCount;
@property (nonatomic, copy, readonly) NSDate   *date;

@end
