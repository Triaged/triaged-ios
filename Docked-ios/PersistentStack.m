//
//  PersistentStack.m
//  Docked-ios
//
//  Created by Charlie White on 10/4/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "PersistentStack.h"

@interface PersistentStack ()

@property (nonatomic,strong,readwrite) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSURL* modelURL;
@property (nonatomic,strong) NSURL* storeURL;
@property (nonatomic,strong) NSPersistentStore* store;

@end


@implementation PersistentStack

- (id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL
{
    self = [super init];
    if (self) {
        self.storeURL = storeURL;
        self.modelURL = modelURL;
        [self setupManagedObjectContext];
    }
    return self;
}

- (void)setupManagedObjectContext
{
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError* error;
    self.store = [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:nil error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
}

- (NSManagedObjectModel*)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)deleteEntireDatabase
{
    NSError *error = nil;
    NSPersistentStoreCoordinator *storeCoordinator = self.managedObjectContext.persistentStoreCoordinator;
    [storeCoordinator removePersistentStore:self.store error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:self.storeURL.path error:&error];
}

- (NSPersistentStoreCoordinator *)resetPersistentStore
{
    NSError *error = nil;
    
    if (self.managedObjectContext.persistentStoreCoordinator == nil)
        return nil;
    // FIXME: dirty. If there are many stores...
    NSPersistentStore *store = [[self.managedObjectContext.persistentStoreCoordinator persistentStores] lastObject];
    
    if (![self.managedObjectContext.persistentStoreCoordinator removePersistentStore:store error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // Delete file
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.store.URL.path]) {
        if (![[NSFileManager defaultManager] removeItemAtPath:self.store.URL.path error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    //Make new persistent store for future saves   (Taken From Above Answer)
    if (![self.managedObjectContext.persistentStoreCoordinator  addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.store.URL options:nil error:&error]) {
        // do something with the error
    }
    
    // Delete the reference to non-existing store
    return nil;
}






@end
