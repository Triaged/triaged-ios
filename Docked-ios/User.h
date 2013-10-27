//
//  User.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MLPAutoCompletionObject.h"

@interface User : MTLModel <MTLJSONSerializing,  MTLManagedObjectSerializing, MLPAutoCompletionObject>

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *avatarUrl;

@end
