//
//  GraphItem.h
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FeedItem.h"

@class GraphDataSet;

@interface GraphItem : FeedItem

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSOrderedSet *dataSets;
@end

@interface GraphItem (CoreDataGeneratedAccessors)

- (void)addDataSetsObject:(GraphDataSet *)value;
- (void)removeDataSetsObject:(GraphDataSet *)value;
- (void)addDataSets:(NSSet *)values;
- (void)removeDataSets:(NSSet *)values;

@end
