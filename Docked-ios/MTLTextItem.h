//
//  TextItem.h
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLFeedItem.h"

@interface MTLTextItem : MTLFeedItem

@property (nonatomic, copy, readonly) NSString *body;

@end
