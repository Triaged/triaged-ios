////
////  Account.m
////  Docked-ios
////
////  Created by Charlie White on 9/23/13.
////  Copyright (c) 2013 Charlie White. All rights reserved.
////
//
//#import "MTLAccount.h"
//#import "DockedRequestAPIClient.h"
//#import "DockedAPIClient.h"
//#import "CredentialStore.h"
//#import "AppDelegate.h"
//#import "Store.h"
//
//@implementation MTLAccount
//
//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//      @"userID": @"id",
//      @"name": @"name",
//      @"email": @"email",
//      @"providers": @"providers",
//      @"followedProviderCount" : @"followed_provider_count",
//      @"companyName" : @"company_name",
//      @"teammates" : @"teammates",
//      @"avatarUrl" : @"avatar_url",
//      @"slug" : @"slug",
//      @"pushEnabled" : @"push_enabled",
//      @"validatedCompany" : @"validated_belongs_to_company",
//      @"personalAccount" : @"personal_account",
//      @"validationToken" : @"company_validation_token",
//      @"apiToken" : @"api_token"
//    };
//}
//
//
//
//+ (NSDictionary *)managedObjectKeysByPropertyKey {
//    return @{
//             @"userID": @"userID",
//             @"name": @"name",
//             @"email": @"email",
//             @"avatarUrl" : @"avatarUrl",
//             @"slug" : @"slug"
//             };
//}
//
//
////+ (NSValueTransformer *)teammatesJSONTransformer
////{
////    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLUser class]];
////}
//
//+ (NSValueTransformer *)providersJSONTransformer
//{
//    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLProvider class]];
//}
//
//
//
//
//+ (void)fetchRemoteUserAccountWithBlock:(void (^)(MTLAccount *))block
//{
//    [[DockedAPIClient sharedClient] GET:@"account.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
//        NSValueTransformer *transformer;
//        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLAccount.class];
//        
//        MTLAccount *currentAccount = [transformer transformedValue:JSON];
//        
//        block(currentAccount);
//    
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure");
//    }];
//}
//
//
//
//-(void)uploadAvatar:(UIImage *)avatar WithBlock:(void (^)(bool))block
//
//{
//        [[DockedRequestAPIClient sharedClient] POST:@"account.json" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                NSData *imageData = UIImageJPEGRepresentation(avatar, 1.0);
//    
//                [formData appendPartWithFileData:imageData name:@"user[avatar]" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSValueTransformer *transformer;
//            transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLAccount.class];
//            
//            [AppDelegate sharedDelegate].store.account = [transformer transformedValue:responseObject];
//            
//            block(true);
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//           block(false);
//        }];
//}
//
//- (void) updatePushEnabled:(BOOL)pushValue
//{
//    if (_pushEnabled != pushValue) {
//        _pushEnabled = pushValue;
//        [self updateRemoteAccount];
//    }
//}
//
//
//-(void)updateRemoteAccount
//{
//    
//    NSDictionary *params = @{@"user" : [MTLJSONAdapter JSONDictionaryFromModel:self]}   ;
//    
//    
//    [[DockedRequestAPIClient sharedClient] PUT:@"account.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSValueTransformer *transformer;
//        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLAccount.class];
//        [AppDelegate sharedDelegate].store.account = [transformer transformedValue:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        NSLog(@"%@", [error localizedDescription]);
//        
//    }];
//}
//
//-(void)welcomeComplete
//{
//    
//    [[DockedRequestAPIClient sharedClient] POST:@"account/welcome_complete.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }];
//}
//
//
//
//
//
//-(BOOL)isLoggedIn {
//    return [[CredentialStore sharedClient] isLoggedIn];
//}
//
//-(void)updateAPNSPushTokenWithToken:(NSString *)token {
//    
//    id params = @{@"push_token" : @{
//                          @"service": @"apns",
//                          @"token": token
//                          }};
//    
//    [[DockedAPIClient sharedClient] POST:@"account/push_tokens.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }];
//}
//
//-(void)resetAPNSPushCount
//{
//    
//    id params = @{@"push_token" : @{
//                        @"service": @"apns"
//                        }};
//    
//    [[DockedAPIClient sharedClient] POST:@"account/push_tokens/reset_count.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }];
//}
//
//-(void)resendVerifyEmail {
//    
//    [[DockedAPIClient sharedClient] POST:@"account/resend_verify_email" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }];
//}
//
//-(void)setValidated {
//    _validatedCompany = YES;
//}
//
//#pragma mark Core Data Getter/Setters
//
////-(void) createUserFromAccount
////{
////    NSString *avatar = self.avatarUrl ? self.avatarUrl : @"";
////    
////    NSDictionary *attributes = @{
////                                 @"userID": self.userID,
////                                 @"name": self.name,
////                                 @"email": self.email,
////                                 @"avatarUrl" : avatar,
////                                 // @"slug" : self.slug
////                                 };
////    
////    MTLUser *user = [[MTLUser alloc] initWithDictionary:attributes error:nil];
////    NSManagedObjectContext *context = [AppDelegate sharedDelegate].store.managedObjectContext;
////    
////    //[MTLManagedObjectAdapter managedObjectFromModel:user insertingIntoContext:context error:nil];
////    
////    // Save teammates to CoreData
////    for(MTLUser* teammate in self.teammates) {
////        NSError *error = nil;
////        //[MTLManagedObjectAdapter managedObjectFromModel:teammate insertingIntoContext:context error:&error];
////    }
////    
////    [context save:nil];
////}
////
////-(MTLUser *)currentUser
////{
////    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
////    request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", _userID];
////    NSArray * fetchedObjects = [[AppDelegate sharedDelegate].store.managedObjectContext executeFetchRequest:request error:nil];
////    return [fetchedObjects firstObject];
////}
//
//-(NSArray *)team
//{
//    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
//    request.predicate = [NSPredicate predicateWithFormat:@"userID != %@ && email != %@", _userID, @"team@triaged.co"];
//    NSArray * fetchedObjects = [[AppDelegate sharedDelegate].store.managedObjectContext executeFetchRequest:request error:nil];
//    return fetchedObjects;
//}
//
//-(NSArray *)connectedProviders
//{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"connected == YES"];
//    return [self.providers filteredArrayUsingPredicate:predicate];
//}
//
//-(NSNumber *)connectedProviderCount
//{
//   
//    return [NSNumber numberWithInt:[self connectedProviders].count];
//}
//
//-(MTLProvider *)providerWithName:(NSString *)name {
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
//    return [[self.providers filteredArrayUsingPredicate:predicate] firstObject];
//}
//
//@end
