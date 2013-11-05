//
//  NSManagedObject+TextItem.h
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSManagedObject (TextItemAccessors)

@property (nonatomic) NSString *body, *property, *action, *providerIcon;
@property (nonatomic) NSDate *timestamp;

@end

