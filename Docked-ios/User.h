//
//  User.h
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MLPAutoCompletionObject.h"

@class Message;

@interface User : NSManagedObject <MLPAutoCompletionObject>

@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSSet *authoredMessages;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAuthoredMessagesObject:(Message *)value;
- (void)removeAuthoredMessagesObject:(Message *)value;
- (void)addAuthoredMessages:(NSSet *)values;
- (void)removeAuthoredMessages:(NSSet *)values;

@end
