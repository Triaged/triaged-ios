//
//  Provider.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface Provider : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *providerID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *iconName;

@end
