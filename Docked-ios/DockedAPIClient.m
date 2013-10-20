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
#import "Store.h"
#import "Account.h"
#import "Mantle.h"
#import "TRJSONResponseSerializerWithData.h"

static NSString * const DockedAPIBaseURLString = @"https://www.triaged.co/api/v1/";

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
        self.responseSerializer = [TRJSONResponseSerializerWithData serializer];
        [self setAuthTokenHeader];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tokenChanged:)
                                                     name:@"token-changed"
                                                   object:nil];
    }
    return self;
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
