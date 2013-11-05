//
//  Alert.h
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "TextCardCell.h"

@interface NewRelicAlert : FeedItem <TextCardProtocol>

@property (nonatomic, copy, readonly) NSString *applicationName;
@property (nonatomic, copy, readonly) NSString *accountName;
@property (nonatomic, copy, readonly) NSString *severity;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *shortMessage;
@property (nonatomic, copy, readonly) NSString *longMessage;


@end
