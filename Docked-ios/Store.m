//
//  Store.m
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Store.h"
#import "MTLFeedItem.h"
#import "Account.h"
#import "DockedAPIClient.h"
#import "AppDelegate.h"
#import "PersistentStack.h"
#import "ConnectionWizardViewController.h"
#import "CredentialStore.h"

//-com.apple.CoreData.SQLDebug 1

@interface Store ()
    @property (nonatomic,strong) NSString *minID;
@end

@implementation Store

@synthesize managedObjectContext;

+ (instancetype)store
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        if ([[CredentialStore sharedClient] isLoggedIn]) {
            [self readAccountArchive];
            [self userLoggedIn];

        }

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userLoggedIn)
                                                     name:@"login"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userSignedOut)
                                                     name:@"signout"
                                                   object:nil];
    }
    return self;
}

- (NSFetchedResultsController*)feedItemsFetchedResultsController
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"FeedItem"];
    [request setFetchBatchSize:200];
    [request setRelationshipKeyPathsForPrefetching:@[@"dataSets"]];
    [request setRelationshipKeyPathsForPrefetching:@[@"dataDetails"]];
    [request setRelationshipKeyPathsForPrefetching:@[@"messages"]];
    [request setRelationshipKeyPathsForPrefetching:@[@"author"]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"updatedAt" ascending:NO]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"externalID" cacheName:nil];
}

//- (FeedItem*)fetchFeedItemWithId:(NSString *)feedItemId;
//{
//    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"FeedItem"];
//    request.predicate = [NSPredicate predicateWithFormat:@"externalID = %@", feedItemId];
//    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"updatedAt" ascending:NO]];
//    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"externalID" cacheName:nil];
//}

#pragma mark - Remote Updates

- (void) fetchRemoteUserAccount
{
    [Account fetchRemoteUserAccountWithBlock:^(Account *account) {
        [self setCurrentAccount:account];
    }];
}

- (void) setCurrentAccount: (Account *)account {
    _account = account;
    
    [_account createUserFromAccount];
    
    [[NSUserDefaults standardUserDefaults] setBool:_account.validatedCompany forKey:@"companyValidated"];
    [self saveAccountToArchive];
    
}

- (void)fetchRemoteFeedItems
{
    [self fetchNewRemoteFeedItemsWithBlock:nil];
}

- (void)fetchNewRemoteFeedItemsWithBlock:(void (^)(NSArray *))block {
    NSDictionary *params;
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *minUpdatedAt = [standardDefaults stringForKey:@"min_updated_at"];
    
    if (minUpdatedAt != nil){
        params = [[NSDictionary alloc] initWithObjectsAndKeys:minUpdatedAt, @"min_updated_at", nil];
    }
    
    [MTLFeedItem fetchNewRemoteFeedItemsWithParams:params andBlock:^(NSArray *newItems) {
        
        if (newItems.count > 0) {
            
            for( MTLFeedItem *item in newItems) {
                NSError *error = nil;
                [MTLManagedObjectAdapter managedObjectFromModel:item insertingIntoContext:self.managedObjectContext error:&error];
                
                if (error != nil) {
                    NSLog(@"%@", [error localizedDescription]);
                }
                
            }
            
            NSError *error = nil;
            [self.managedObjectContext save:&error];
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            
            MTLFeedItem *latestItem = [newItems firstObject];
            NSString *minUpdated = [Store.dateFormatter stringFromDate:latestItem.updatedAt];
            [standardDefaults setObject:minUpdated forKey:@"min_updated_at"];
            [standardDefaults synchronize];
        }
        
        // Need to call to ensure table views stop refreshing
        [self feedWasUpdated];
        
        if (block) block(newItems);
    }];
}

#pragma mark - Feed methods

- (NSArray *)sortedTableFeed {
    NSArray *sortedFeedItems = [self sortFeedItems];
    NSMutableArray *feed = [[NSMutableArray alloc] initWithCapacity:sortedFeedItems.count];
    
    for (MTLFeedItem *item in sortedFeedItems) {
        [feed addObject:[self buildGroupedFeedItem:item]];
    }
    
    return [NSArray arrayWithArray:feed];
}

- (void) feedWasUpdated {
    // Send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
}

- (NSArray *)sortFeedItems
{
    return [self.feedItems sortedArrayUsingComparator:^NSComparisonResult(MTLFeedItem *feedItem1, MTLFeedItem *feedItem2) {
        return [feedItem2.updatedAt compare:feedItem1.updatedAt];
    }];
}

- (NSArray *)buildGroupedFeedItem:(MTLFeedItem *)feedItem
{
    NSMutableArray *groupedFeedItem = [[NSMutableArray alloc] initWithObjects:feedItem, nil];
    if (feedItem.messages.count > 0) {
        [groupedFeedItem addObject:[feedItem.sortedMessages firstObject]];
    }
    return [NSArray arrayWithArray:groupedFeedItem];
}

#pragma mark - User Authentication

- (void) userLoggedIn
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [self fetchRemoteFeedItems];
    [Intercom beginSessionForUserWithUserId:_account.userID andEmail:_account.email];
}

- (void) userSignedOut
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults removeObjectForKey:@"min_updated_at"];
    [standardDefaults removeObjectForKey:@"companyValidated"];
    [standardDefaults synchronize];
    
    [Intercom endSession];
    
    [[AppDelegate sharedDelegate].persistentStack resetPersistentStore];
}



#pragma mark - NSKeyArchiving



- (void)readAccountArchive
{
    NSString     * path         = [self pathForAccountFile];
    NSDictionary * rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _account = [rootObject valueForKey:@"account"];
    
    [self fetchRemoteUserAccount];
}

- (void)saveAccountToArchive
{
    NSString * path = [self pathForAccountFile];
    NSMutableDictionary * rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:_account forKey:@"account"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

- (BOOL)deleteAccountArchive
{
    NSString * path = [self pathForAccountFile];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exists = [fm fileExistsAtPath:path];
    if(exists == YES) return [fm removeItemAtPath:path error:nil];
    return exists;
}

- (NSString *) pathForAccountFile
{
    NSArray*	documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*	path = nil;
	
    if (documentDir) {
        path = [documentDir objectAtIndex:0];
    }
	
    return [NSString stringWithFormat:@"%@/%@", path, @"account.bin"];
}
        
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    return dateFormatter;
}





@end
