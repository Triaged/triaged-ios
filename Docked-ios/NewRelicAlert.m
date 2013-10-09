//
//  Alert.m
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicAlert.h"

@implementation NewRelicAlert

-(NSString*)property {
    return [self.applicationName capitalizedString];
}


-(NSString *)body {
    return self.message;
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"newrelic.png"];
}

-(Class)tableViewCellClass {
    return [TextCardCell class];
}

@end
