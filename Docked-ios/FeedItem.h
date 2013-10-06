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

@interface FeedItem : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, copy, readonly) NSString *htmlUrl;
@property (nonatomic, copy, readonly) NSArray *messages;
@property (nonatomic, copy, readonly) NSDate *timestamp;

-(NSString *)property;
-(NSString *)body;
-(NSString *)action;
-(UIImage  *)providerIcon;

-(NSArray *)chartCoordinates;

-(NSNumber *)firstDataField;
-(NSNumber *)secondDataField;
-(NSNumber *)thirdDataField;

+ (NSMutableArray *)loadFeedItems;

@end
