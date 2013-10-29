//
//  GraphDataDetails.h
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GraphDataSet;

@interface GraphDataDetail : NSManagedObject

@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) GraphDataSet *graphDataSet;

@end
