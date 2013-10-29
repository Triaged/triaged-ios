//
//  TextItem.h
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FeedItem.h"


@interface TextItem : FeedItem

@property (nonatomic, retain) NSString * body;

@end
