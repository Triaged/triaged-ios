//
//  FeedItem.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Message.h"

@protocol DataSourceItem <NSObject>
-(Class)tableViewCellClass;
@end

@interface FeedItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, copy, readonly) NSArray *messages;



-(NSString *) eventName;
-(NSString *)titleLabel;
-(NSString *)bodyLabel;
-(NSString *)externalLinkUrl;
-(UIImage*)icon;
-(Class)detailViewControllerClass;

+ (NSMutableArray *)loadFeedItems;

@end
