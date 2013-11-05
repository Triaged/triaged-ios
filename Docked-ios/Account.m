//
//  Account.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Account.h"
#import "Provider.h"
#import "DockedRequestAPIClient.h"
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
        
        block(currentAccount);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

-(void) createUserFromAccount
{
    NSString *avatar = self.avatarUrl ? self.avatarUrl : @"";
    
    NSDictionary *attributes = @{
                    @"userID": self.userID,
                    @"name": self.name,
                    @"email": self.email,
                    @"avatarUrl" : avatar,
                   // @"slug" : self.slug
                };
    
    
    
    MTLUser *user = [[MTLUser alloc] initWithDictionary:attributes error:nil];
    
    NSManagedObjectContext *context = [AppDelegate sharedDelegate].store.managedObjectContext;
    [MTLManagedObjectAdapter managedObjectFromModel:user insertingIntoContext:context error:nil];
    [context save:nil];
}

-(void)uploadAvatar:(UIImage *)avatar WithBlock:(void (^)(bool))block

{
        [[DockedRequestAPIClient sharedClient] POST:@"account.json" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                NSData *imageData = UIImageJPEGRepresentation(avatar, 1.0);
    
                [formData appendPartWithFileData:imageData name:@"user[avatar]" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSValueTransformer *transformer;
            transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Account.class];
            
            [AppDelegate sharedDelegate].store.account = [transformer transformedValue:responseObject];
            
            block(true);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           block(false);
        }];
}



-(void)uploadProfilePicture:(UIImage *)profilePicture
{
//    
//    [[DockedAPIClient sharedClient] POST:@"account/avatar.json" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            NSData *imageData = UIImageJPEGRepresentation(profilePicture, 1.0);
//
//            [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"success");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure");
//    }];
    NSString *url = @"https://www.triaged.co/api/v1/account.json";
    NSURL *requestURL = [NSURL URLWithString:url];
    NSString *FileParamConstant = @"user[avatar]";
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"PUT"];
    
    // set Content-Type in HTTP header
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    CredentialStore *store = [[CredentialStore alloc] init];
    NSString *authToken = [store authToken];
    [request setValue:authToken forHTTPHeaderField:@"authorization"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
//    for (NSString *param in _params) {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(profilePicture, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:requestURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:nil];
}



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

-(NSArray *)connectedProviders
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"connected == YES"];
    return [[self.providers allValues] filteredArrayUsingPredicate:predicate];
}

-(NSNumber *)connectedProviderCount
{
   
    return [NSNumber numberWithInt:[self connectedProviders].count];
}

@end
