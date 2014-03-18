//
//  Account.h
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@class User;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * apiToken;
@property (nonatomic, retain) NSString * followedProvidersCount;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * personalAccount;
@property (nonatomic, retain) NSString * pushEnabled;
@property (nonatomic, retain) NSString * validatedCompany;
@property (nonatomic, retain) NSString * validationToken;
@property (nonatomic, retain) User *currentUser;
@property (nonatomic, retain) NSSet *teammates;
@property (nonatomic, retain) NSSet *providers;

+ (void)currentAccountWithCompletionHandler:(void(^)(Account *account, NSError *error))completionHandler;


@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addTeammatesObject:(User *)value;
- (void)removeTeammatesObject:(User *)value;
- (void)addTeammates:(NSSet *)values;
- (void)removeTeammates:(NSSet *)values;

@end
