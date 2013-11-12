//
//  CredentialStore.m
//  Docked-ios
//
//  Created by Charlie White on 9/21/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CredentialStore.h"

#import "CredentialStore.h"
#import "SSKeychain.h"

#define SERVICE_NAME @"Triage-AuthClient"
#define AUTH_TOKEN_KEY @"auth_token"

@implementation CredentialStore

+ (instancetype)sharedClient {
    static CredentialStore *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SSKeychain setAccessibilityType:kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly];
        _sharedClient = [[CredentialStore alloc] init];
    });
    
    return _sharedClient;
}

- (BOOL)isLoggedIn {
    return [self authToken] != nil;
}

- (void)clearSavedCredentials {
    [self setAuthToken:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"signout" object:self];
}

- (NSString *)authToken {
    return [self secureValueForKey:AUTH_TOKEN_KEY];
}

- (void)setAuthToken:(NSString *)authToken {
    [self setSecureValue:authToken forKey:AUTH_TOKEN_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"token-changed" object:self];
}

- (void)setSecureValue:(NSString *)value forKey:(NSString *)key {
    if (value) {
        [SSKeychain setPassword:value
                     forService:SERVICE_NAME
                        account:key];
    } else {
        [SSKeychain deletePasswordForService:SERVICE_NAME account:key];
    }
}

- (NSString *)secureValueForKey:(NSString *)key {
    NSError *error = nil;
    NSString *result = [SSKeychain passwordForService:SERVICE_NAME account:key error:&error];
    
    if ([error code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (error != nil) {
        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
    }
    
    return result;
}

@end
