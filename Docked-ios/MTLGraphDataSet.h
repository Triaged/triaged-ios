//
//  MTLGraphDataSet.h
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mantle.h"
#import "MTLGraphItem.h"

@interface MTLGraphDataSet : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSNumber *totalDataCount;
@property (nonatomic, copy, readonly) NSNumber *maxYCount;
@property (nonatomic, copy, readonly) NSArray *dataDetails;

@end
