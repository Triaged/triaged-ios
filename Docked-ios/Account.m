//
//  Account.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Account.h"
#import "Provider.h"
#import "DockedAPIClient.h"
#import "CredentialStore.h"
#import "MTLUser.h"
#import "AppDelegate.h"
#import "Store.h"

@implementation Account

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
      @"userID": @"id",
      @"name": @"name",
      @"email": @"email",
      @"providers": @"providers",
      @"followedProviderCount" : @"followed_provider_count",
      @"companyName" : @"company_name",
      @"teammates" : @"teammates",
      @"avatarUrl" : @"avatar_url",
      @"slug" : @"slug"
    };
}



+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
             @"userID": @"userID",
             @"name": @"name",
             @"email": @"email",
             @"avatarUrl" : @"avatarUrl",
             @"slug" : @"slug"
             };
}


+ (NSValueTransformer *)teammatesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLUser class]];
}


+ (void)fetchRemoteUserAccountWithBlock:(void (^)(Account *))block
{
    [[DockedAPIClient sharedClient] GET:@"account.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Account.class];
        
        Account *currentAccount = [transformer transformedValue:JSON];
        
        [currentAccount createUserFromAccount];
        
        block(currentAccount);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

-(void) createUserFromAccount
{
    NSDictionary *attributes = @{
                    @"userID": self.userID,
                    @"name": self.name,
                    @"email": self.email,
                    @"avatarUrl" : self.avatarUrl,
                   // @"slug" : self.slug
                };
    
    MTLUser *user = [[MTLUser alloc] initWithDictionary:attributes error:nil];
    
    NSManagedObjectContext *context = [AppDelegate sharedDelegate].store.managedObjectContext;
    [MTLManagedObjectAdapter managedObjectFromModel:user insertingIntoContext:context error:nil];
    [context save:nil];
}



-(void)uploadProfilePicture:(UIImage *)profilePicture
{
    
//    [[DockedAPIClient sharedClient] POST:@"account/avatar.json" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            NSData *imageData = UIImageJPEGRepresentation(profilePicture, 1.0);
//
//            [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"success");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure");
//    }];
    NSData *imageData = UIImageJPEGRepresentation(profilePicture, 1.0);
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *tmpFile = [tmpDirectory stringByAppendingPathComponent:@"avatar.jpg"];
    [imageData writeToFile:tmpFile atomically:YES];
    
    [[DockedAPIClient sharedClient] POST:@"account/avatar.json" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:tmpFile];
        [formData appendPartWithFileURL:fileURL name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg" error:nil];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"success");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
    
}

//- (void)postData:(NSData *)data
//            name:(NSString *)name
//        fileName:(NSString *)fileName
//        mimeType:(NSString *)mimeType
//             url:(NSURL *)url
//      parameters:(NSDictionary *)parameters
//         success:(void(^)(id responseObject))success
//         failure:(void(^)(NSError *error))failure {
//    NSAssert( data.length > 0, @"You must provide some data to upload" );
//    
//    AFHTTPRequestSerializer *serializer = ( AFHTTPRequestSerializer * )[DockedAPIClient sharedClient].requestSerializer;
//    
//    NSMutableURLRequest *request =
//    [serializer multipartFormRequestWithMethod:@"POST"
//                                     URLString:[[NSURL URLWithString:[url absoluteString] relativeToURL:[DockedAPIClient sharedClient].baseURL] absoluteString]
//                                    parameters:parameters
//                     constructingBodyWithBlock:^(id < AFMultipartFormData > formData) {
//                         if ( mimeType.length > 0 && name.length > 0 && fileName.length > 0 ) {
//                             [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
//                         }
//                         else if ( name.length > 0 ) {
//                             [formData appendPartWithFormData:data name:name];
//                         }
//                         else {
//                             NSAssert( NO, @"You must provide data & name or data & name & fileName & mimeType. No other options are allowed." );
//                         }
//                     }];
//    
//    NSError *streamError;
//    NSString *temporaryFileName = [request.HTTPBodyStream writeToTemporaryFileWithError:&streamError];
//    if ( !temporaryFileName ) {
//        TM_CALL_BLOCK( failure, streamError );
//        return;
//    }
//    
//    NSURLSessionUploadTask *task =
//    [[DockedAPIClient sharedClient] uploadTaskWithRequest:request
//                                      fromFile:[NSURL fileURLWithPath:temporaryFileName]
//                                      progress:nil
//                             completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//                                 [[NSFileManager defaultManager] removeItemAtPath:temporaryFileName error:nil];
//                                 NSHTTPURLResponse *httpResponse = ( NSHTTPURLResponse * )response;
//                                 if ( httpResponse.statusCode == 200 && error == nil ) {
//                                     TM_CALL_BLOCK( success, responseObject );
//                                     return;
//                                 }
//                                 TM_CALL_BLOCK( failure, error );
//                             }];
//    [task resume];
//}

-(BOOL)isLoggedIn {
    return [[CredentialStore sharedClient] isLoggedIn];
}

-(void)updateAPNSPushTokenWithToken:(NSString *)token {
    
    id params = @{@"push_token" : @{
                          @"service": @"apns",
                          @"token": token
                          }};
    
    [[DockedAPIClient sharedClient] POST:@"account/push_tokens.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

-(void)resetAPNSPushCount
{
    
    id params = @{@"push_token" : @{
                        @"service": @"apns"
                        }};
    
    [[DockedAPIClient sharedClient] POST:@"account/push_tokens/reset_count.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

-(User *)currentUser
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", _userID];
    NSArray * fetchedObjects = [[AppDelegate sharedDelegate].store.managedObjectContext executeFetchRequest:request error:nil];
    return [fetchedObjects firstObject];
}

-(NSArray *)team
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"userID != %@", _userID];
    NSArray * fetchedObjects = [[AppDelegate sharedDelegate].store.managedObjectContext executeFetchRequest:request error:nil];
    return fetchedObjects;
}

-(NSNumber *)connectedCount
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"connected == YES"];
    NSArray *results = [[self.providers allValues] filteredArrayUsingPredicate:predicate];
    return [NSNumber numberWithInt:results.count];
}






@end
