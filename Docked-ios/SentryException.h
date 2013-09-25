//
//  SentryException.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface SentryException : FeedItem

@property (nonatomic, copy, readonly) NSString *sentryExceptionID;
@property (nonatomic, copy, readonly) NSString *project;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *culprit;
@property (nonatomic, copy, readonly) NSString *logger;
@property (nonatomic, copy, readonly) NSString *level;


@end
