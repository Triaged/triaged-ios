//
//  GraphDataSet.h
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GraphDataDetail, GraphItem;

@interface GraphDataSet : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * totalDataCount;
@property (nonatomic, retain) NSNumber * maxYCount;
@property (nonatomic, retain) GraphItem *graphItem;
@property (nonatomic, retain) NSOrderedSet *dataDetails;

@end
