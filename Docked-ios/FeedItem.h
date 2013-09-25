//
//  FeedItem.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface FeedItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *body;

-(NSString *) eventName;
-(NSString *)titleLabel;
-(NSString *)bodyLabel;
-(UIImage*)icon;
-(Class)detailViewControllerClass;

@end
