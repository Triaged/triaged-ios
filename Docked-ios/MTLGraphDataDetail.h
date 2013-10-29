//
//  MTLGraphDataDetail.h
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mantle.h"
#import "MTLGraphDataSet.h"

@interface MTLGraphDataDetail : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSDecimalNumber *x;
@property (nonatomic, copy, readonly) NSDecimalNumber *y;
@property (nonatomic, copy, readonly) NSDecimalNumber *index;

@end
