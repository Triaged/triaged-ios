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
#import "BeanstalkSettingsViewController.h"
#import "CrashlyticsSettingsViewController.h"
#import "AppfiguresSettingsViewController.h"
#import "HockeyAppSettingsViewController.h"
#import "BraintreeSettingsViewController.h"
#import "BitbucketSettingsViewController.h"


@implementation Provider

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
     @"providerID": @"id",
     @"name" : @"name",
     @"connected" : @"connected",
     @"follows" : @"follows",
     @"webhookUrl" : @"webhook_url",
     @"account" : @"account"
    };
}


+ (NSValueTransformer *)accountJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MTLProviderAccount class]];
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
    
    NSString *path = [NSString stringWithFormat:@"providers/%@/ignore.json", _providerID];
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
    @{  @"name" : @"GitHub",
        @"short_name" : @"GitHub",
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
    @{  @"name" : @"Crashlytics",
        @"short_name" : @"crashlytics",
        @"id"   : @"crashlytics",
        @"icon" : @"crashlytics.png",
        @"settings_icon" : @"crashlytics-s.png",
        @"settings_class" : CrashlyticsSettingsViewController.class
    },
    @{  @"name" : @"AppFigures",
        @"short_name" : @"AppFigures",
        @"id"   : @"appfigures",
        @"icon" : @"appfigures.png",
        @"settings_icon" : @"appfigures-s.png",
        @"settings_class" : AppfiguresSettingsViewController.class
    },
    @{  @"name" : @"HockeyApp",
        @"short_name" : @"HockeyApp",
        @"id"   : @"hockey_app",
        @"icon" : @"hockey_app.png",
        @"settings_icon" : @"hockey_app-s.png",
        @"settings_class" : HockeyAppSettingsViewController.class
    },
    @{  @"name" : @"Beanstalk",
        @"short_name" : @"Beanstalk",
        @"id"   : @"beanstalk",
        @"icon" : @"beanstalk.png",
        @"settings_icon" : @"beanstalk-s.png",
        @"settings_class" : BeanstalkSettingsViewController.class
    },
    @{  @"name" : @"Braintree",
        @"short_name" : @"Braintree",
        @"id"   : @"braintree",
        @"icon" : @"braintree.png",
        @"settings_icon" : @"braintree-s.png",
        @"settings_class" : BraintreeSettingsViewController.class
    },
    @{  @"name" : @"Bitbucket",
        @"short_name" : @"Bitbucket",
        @"id"   : @"bitbucket",
        @"icon" : @"bitbucket.png",
        @"settings_icon" : @"bitbucket-s.png",
        @"settings_class" : BitbucketSettingsViewController.class
        },
    nil];
    

}

+ (NSDictionary *)settingsDictForProvider:(NSString *)providerName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", providerName];
    return [[[Provider currentProviders] filteredArrayUsingPredicate:predicate] firstObject];
}

@end
