//
//  FetchedMessagesDataSource.h
//  Docked-ios
//
//  Created by Charlie White on 10/15/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchedMessagesDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

- (id)messageAtIndexPath:(NSIndexPath *)indexPath;

@end
