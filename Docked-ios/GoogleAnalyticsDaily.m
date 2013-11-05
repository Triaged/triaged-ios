//
//  GoogleAnalyticsDailyStatus.m
//  Docked-ios
//
//  Created by Charlie White on 10/2/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GoogleAnalyticsDaily.h"
#import "GraphDataCell.h"

@implementation GoogleAnalyticsDaily

+ (NSDateFormatter *)dayDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
   NSDictionary *jsonKeys = @{
             @"visitsSum": @"visits_sum",
             @"visitorsSum": @"visitors_sum",
             @"pageViewsSum": @"pageviews_sum",
             @"date": @"date",
             @"dailyDetails": @"daily_details",
             };
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"GoogleAnalyticsDaily";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{@"dailyDetails" : GoogleAnalyticsDailyStatusDetails.class}];
}

+ (NSValueTransformer *)dailyDetailsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GoogleAnalyticsDailyStatusDetails class]];
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dayDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dayDateFormatter stringFromDate:date];
    }];
}


-(NSString*)property {
    return @"Docked.com";
}

-(NSString *) action {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [dateFormatter stringFromDate:_date];}


-(NSString *)body {
    return @"";
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"google_analytics.png"];
}

-(NSArray *)firstCoordinates {
    NSMutableArray *chartCoordinates = [[NSMutableArray alloc] initWithCapacity:self.dailyDetails.count];
    for(GoogleAnalyticsDailyStatusDetails *detail in self.dailyDetails) {
//        [chartCoordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:detail.date, @"date", detail.visitsCount, @"visits", nil]];
        [chartCoordinates addObject:detail.visitsCount];
    }
    return [NSArray arrayWithArray:chartCoordinates];
}

-(NSArray *)secondCoordinates {
    NSMutableArray *chartCoordinates = [[NSMutableArray alloc] initWithCapacity:self.dailyDetails.count];
    for(GoogleAnalyticsDailyStatusDetails *detail in self.dailyDetails) {
        [chartCoordinates addObject:detail.visitorsCount];
    }
    return [NSArray arrayWithArray:chartCoordinates];
}

-(NSArray *)thirdCoordinates {
    NSMutableArray *chartCoordinates = [[NSMutableArray alloc] initWithCapacity:self.dailyDetails.count];
    for(GoogleAnalyticsDailyStatusDetails *detail in self.dailyDetails) {
        //        [chartCoordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:detail.date, @"date", detail.visitsCount, @"visits", nil]];
        [chartCoordinates addObject:detail.pageViewsCount];
    }
    return [NSArray arrayWithArray:chartCoordinates];
}

-(NSNumber *)maxYCoordinate
{
    NSNumber *maxY = 0;
    for(GoogleAnalyticsDailyStatusDetails *detail in self.dailyDetails) {
        if( detail.visitsCount > maxY) maxY = detail.visitsCount;
    }
    return maxY;
}

-(NSNumber *)firstDataField {
    return _visitsSum;
}
-(NSNumber *)secondDataField {
    return _visitorsSum;
}
-(NSNumber *)thirdDataField {
    return _pageViewsSum;
}

-(Class)tableViewCellClass {
    return [GraphDataCell class];
}
@end
