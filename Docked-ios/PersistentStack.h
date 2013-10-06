//
//  PersistentStack.h
//  Docked-ios
//
//  Created by Charlie White on 10/4/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistentStack : NSObject

@property (nonatomic,strong,readonly) NSManagedObjectContext* managedObjectContext;

- (id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL;
- (void)saveContext;


@end
