//
//  FeedItemsDataSource.h
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItemsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *feedItems;


- (id)initWithItems:(NSArray *)anItems;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
