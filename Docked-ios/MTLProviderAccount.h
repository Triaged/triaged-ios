//
//  MTLProviderAccount.h
//  Triage-ios
//
//  Created by Charlie White on 11/8/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLProviderProperty.h"

@interface MTLProviderAccount : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *accountID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *accountLabel;
@property (nonatomic, copy, readonly) NSString *propertyLabel;
@property (nonatomic, copy, readonly) NSArray *properties;

@end
