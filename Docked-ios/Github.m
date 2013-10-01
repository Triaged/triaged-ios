//
//  Github.m
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Github.h"
#import "TextCardCell.h"

@implementation Github

-(UIImage *)icon {
    UIImage *icon = [UIImage imageNamed:@"github.png"];
    return icon;
}

-(Class)tableViewCellClass {
    return [TextCardCell class];
}

@end
