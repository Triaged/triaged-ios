//
//  KilnCommit.h
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface KilnCommit : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSString *author;
@property (nonatomic, copy, readonly) NSString *branch;
@property (nonatomic, copy, readonly) NSDate *timestamp;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *url;

@end
