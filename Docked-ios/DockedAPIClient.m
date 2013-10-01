//
//  DockedAPIClient.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "DockedAPIClient.h"
#import "CredentialStore.h"
#import "AppDelegate.h"
#import "Account.h"
#import "Mantle.h"

static NSString * const DockedAPIBaseURLString = @"http://docked-rails.herokuapp.com/api/v1/";

@implementation DockedAPIClient

+ (instancetype)sharedClient {
    static DockedAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DockedAPIClient alloc] initWithBaseURL:[NSURL URLWithString:DockedAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self setAuthTokenHeader];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tokenChanged:)
                                                     name:@"token-changed"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fetchRemoteUserAccount)
                                                     name:@"login"
                                                   object:nil];
       
    }
    return self;
}

- (void) fetchRemoteUserAccount {
    [[DockedAPIClient sharedClient] GET:@"account.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSDictionary *results = [JSON valueForKeyPath:@"account"];
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Account.class];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.userAccount = [transformer transformedValue:results];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
    
}



- (void)setAuthTokenHeader {
    CredentialStore *store = [[CredentialStore alloc] init];
    NSString *authToken = [store authToken];
    [self.requestSerializer setValue:authToken forHTTPHeaderField:@"authorization"];
}

- (void)tokenChanged:(NSNotification *)notification {
    [self setAuthTokenHeader];
}

@end
