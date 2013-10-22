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

- (void) unfollow {
     _follows = false;
    
    NSString *path = [NSString stringWithFormat:@"providers/%@/unfollow.json", _providerID];
    [[DockedAPIClient sharedClient] POST:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // Reset back, if the post fails
        _follows = true;
    }];
}

- (void) connect
{
    _connected = true;
}

+ (NSArray *)currentProviders
{

    return [NSArray arrayWithObjects:
    @{  @"name" : @"Google Analytics",
        @"icon" : @"google_analytics.png",
        @"settings_class" : GoogleAnalyticsSettingsViewController.class
    },
    @{  @"name" : @"Sentry",
        @"icon" : @"sentry.png",
        @"settings_class" : SentrySettingsViewController.class
    },
    @{  @"name" : @"Heroku",
        @"icon" : @"heroku.png",
        @"settings_class" : HerokuSettingsViewController.class
    },
    @{  @"name" : @"New Relic",
        @"icon" : @"new_relic.png",
        @"settings_class" : NewRelicSettingsViewController.class
    },
    @{  @"name" : @"Airbrake",
        @"icon" : @"airbrake.png",
        @"settings_class" : AirbrakeSettingsViewController.class
    },
    @{  @"name" : @"Github",
        @"icon" : @"github.png",
        @"settings_class" : GithubSettingsViewController.class
    },
    @{  @"name" : @"Stripe",
        @"icon" : @"stripe.png",
        @"settings_class" : StripeSettingsViewController.class
    },
    @{  @"name" : @"Kiln",
        @"icon" : @"kiln.png",
        @"settings_class" : KilnSettingsViewController.class
    },
    nil];
    

}

@end
