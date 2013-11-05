//
//  Provider.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Provider.h"
#import "DockedAPIClient.h"
#import "GoogleAnalyticsSettingsViewController.h"
#import "SentrySettingsViewController.h"
#import "StripeSettingsViewController.h"
#import "GithubSettingsViewController.h"
#import "NewRelicSettingsViewController.h"
#import "HerokuSettingsViewController.h"
#import "AirbrakeSettingsViewController.h"
#import "KilnSettingsViewController.h"


@implementation Provider

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
     @"providerID": @"id",
     @"name" : @"name",
     @"connected" : @"connected",
     @"follows" : @"follows",
     @"webhookUrl" : @"webhook_url"
    };
}



- (void) connect
{
    _connected = true;
}

- (void) follow {
    
    // set this locally first
    _follows = true;
    
    NSString *path = [NSString stringWithFormat:@"providers/%@/follow.json", _providerID];
    [[DockedAPIClient sharedClient] POST:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // reset back if the post fails
        _follows = false;
    }];
}

- (void) ignore {
    _follows = false;
    
    NSString *path = [NSString stringWithFormat:@"providers/%@/unfollow.json", _providerID];
    [[DockedAPIClient sharedClient] POST:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // Reset back, if the post fails
        _follows = true;
    }];
}

- (void) emailConnectInstructions
{
    //[[AppDelegate sharedDelegate].navVC showSGProgressWithDuration:1.5];

    NSString *path = [NSString stringWithFormat:@"providers/%@/email_connect_instructions", self.providerID];
    
    [[DockedAPIClient sharedClient] POST:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

+ (NSArray *)currentProviders
{

    return [NSArray arrayWithObjects:
    @{  @"name" : @"Google Analytics",
        @"short_name" : @"Google",
        @"id"   : @"google_analytics",
        @"icon" : @"google_analytics.png",
        @"settings_icon" : @"google_analytics-s.png",
        @"settings_class" : GoogleAnalyticsSettingsViewController.class
    },
    @{  @"name" : @"Sentry",
        @"short_name" : @"Sentry",
        @"id"   : @"sentry",
        @"icon" : @"sentry.png",
        @"settings_icon" : @"sentry-s.png",
        @"settings_class" : SentrySettingsViewController.class
    },
    @{  @"name" : @"Heroku",
        @"short_name" : @"Heroku",
        @"id"   : @"heroku",
        @"icon" : @"heroku.png",
        @"settings_icon" : @"heroku-s.png",
        @"settings_class" : HerokuSettingsViewController.class
    },
    @{  @"name" : @"New Relic",
        @"short_name" : @"New Relic",
        @"id"   : @"new_relic",
        @"icon" : @"new_relic.png",
        @"settings_icon" : @"new_relic-s.png",
        @"settings_class" : NewRelicSettingsViewController.class
    },
    @{  @"name" : @"Airbrake",
        @"short_name" : @"Airbrake",
        @"id"   : @"airbrake",
        @"icon" : @"airbrake.png",
        @"settings_icon" : @"airbrake-s.png",
        @"settings_class" : AirbrakeSettingsViewController.class
    },
    @{  @"name" : @"Github",
        @"short_name" : @"Github",
        @"id"   : @"github",
        @"icon" : @"github.png",
        @"settings_icon" : @"github-s.png",
        @"settings_class" : GithubSettingsViewController.class
    },
    @{  @"name" : @"Stripe",
        @"short_name" : @"Stripe",
        @"id"   : @"stripe",
        @"icon" : @"stripe.png",
        @"settings_icon" : @"stripe-s.png",
        @"settings_class" : StripeSettingsViewController.class
    },
    @{  @"name" : @"Kiln",
        @"short_name" : @"Kiln",
        @"id"   : @"kiln",
        @"icon" : @"kiln.png",
        @"settings_icon" : @"kiln-s.png",
        @"settings_class" : KilnSettingsViewController.class
    },
    nil];
    

}

+ (NSDictionary *)settingsDictForProvider:(NSString *)providerName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", providerName];
    return [[[Provider currentProviders] filteredArrayUsingPredicate:predicate] firstObject];
}

@end
