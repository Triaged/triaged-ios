//
//  Message.h
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeedItem, User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) FeedItem *feedItem;
@end


@interface Message (CoreDataGeneratedAccessors)

- (void)createWithCompletionHandler:(void(^)(id managedObject, NSError *error))completionHandler;

@end
