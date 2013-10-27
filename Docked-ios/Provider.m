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
     @"webhookUrl" : @"webhook_url"
    };
}



- (void) connect
{
    _connected = true;
}

+ (NSArray *)currentProviders
{

    return [NSArray arrayWithObjects:
    @{  @"name" : @"Google Analytics",
        @"id"   : @"google_analytics",
        @"icon" : @"google_analytics.png",
        @"settings_class" : GoogleAnalyticsSettingsViewController.class
    },
    @{  @"name" : @"Sentry",
        @"id"   : @"sentry",
        @"icon" : @"sentry.png",
        @"settings_class" : SentrySettingsViewController.class
    },
    @{  @"name" : @"Heroku",
        @"id"   : @"heroku",
        @"icon" : @"heroku.png",
        @"settings_class" : HerokuSettingsViewController.class
    },
    @{  @"name" : @"New Relic",
        @"id"   : @"new_relic",
        @"icon" : @"new_relic.png",
        @"settings_class" : NewRelicSettingsViewController.class
    },
    @{  @"name" : @"Airbrake",
        @"id"   : @"airbrake",
        @"icon" : @"airbrake.png",
        @"settings_class" : AirbrakeSettingsViewController.class
    },
    @{  @"name" : @"Github",
        @"id"   : @"github",
        @"icon" : @"github.png",
        @"settings_class" : GithubSettingsViewController.class
    },
    @{  @"name" : @"Stripe",
        @"id"   : @"stripe",
        @"icon" : @"stripe.png",
        @"settings_class" : StripeSettingsViewController.class
    },
    @{  @"name" : @"Kiln",
        @"id"   : @"kiln",
        @"icon" : @"kiln.png",
        @"settings_class" : KilnSettingsViewController.class
    },
    nil];
    

}

@end
