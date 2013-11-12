//
//  MTLProviderProperty.h
//  Triage-ios
//
//  Created by Charlie White on 11/8/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Provider.h"
#import "MTLProviderAccount.h"

@class Provider;
@class MTLProviderAccount;

@interface MTLProviderProperty : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *propertyID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) BOOL follows;

- (void) followWithProvider:(Provider *)provider andAccount:(MTLProviderAccount *)account;
- (void) ignoreWithProvider:(Provider *)provider andAccount:(MTLProviderAccount *)account;


@end
