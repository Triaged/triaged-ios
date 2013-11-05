//
//  Deployment.m
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicDeployment.h"
#import "TextCardCell.h"

@implementation NewRelicDeployment

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
       @"applicationName": @"application_name",
       @"accountName": @"account_name",
       @"changelog": @"changelog",
       @"descrip": @"description",
       @"revision": @"revision",
       @"deployedBy": @"deployed_by"
       };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"NewRelicDeployment";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}



-(NSString*)property {
    return [self.applicationName capitalizedString];
}


-(NSString *)body {
    return self.description;
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"newrelic.png"];
}

-(NSString *) action {
    return @"deployment";
}

-(Class)tableViewCellClass {
    return [TextCardCell class];
}

@end
