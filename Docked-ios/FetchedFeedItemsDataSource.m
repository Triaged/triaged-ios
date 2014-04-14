//
//  FetchedFeedItemsDataSource.m
//  Triage-ios
//
//  Created by Charlie White on 3/5/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "FetchedFeedItemsDataSource.h"
#import "EventCard.h"
#import "FeedItemCell.h"
#import "SpacerCell.h"
#import "NSDate+TimeAgo.h"
#import "CardViewController.h"
#import "FeedSectionViewController.h"
#import "UIView+BlurredSnapshot.h"


#define kLCellSpacerHeight      16.0f
#define kVerticalMargin 0.0f

@implementation FetchedFeedItemsDataSource

@synthesize fetchedResultsController, tableViewController, detail;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *path = [NSIndexPath indexPathForItem:(indexPath.row / 2) inSection:indexPath.section];
    return [fetchedResultsController objectAtIndexPath:path];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects] * 2 + 1;
    } else
        return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row % 2 != 1) {
        return [self cellForSpacerWith:tableView andIndexPath:indexPath];
    }else {
        return [self cellForFeedItemWith:tableView andIndexPath:indexPath];
    }
}

- (UITableViewCell*) cellForSpacerWith:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SpacerCell";
    SpacerCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ SpacerCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    return cell;
}


- (UITableViewCell*) cellForFeedItemWith:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath {
    FeedItem *item = [self itemAtIndexPath:indexPath];
    
    Class cellClass = item.itemCellClass;
    NSString *cellID = NSStringFromClass(cellClass);
    
    if (item.imageUrl) {
        cellID = [NSString stringWithFormat:@"%@-image",cellID];
    }
    
    if (item.user) {
        cellID = [NSString stringWithFormat:@"%@-user",cellID];
    }
    
    FeedItemCell *cell = [ tableView dequeueReusableCellWithIdentifier:cellID ] ;
    if ( !cell )
    {
        cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    }
    
    [cell configureForItem:item];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    FeedItem * item = [self itemAtIndexPath:indexPath];
//    
//    CardViewController *detailVC = [[CardViewController alloc] init];
//    [detailVC setFeedItem:item];
//    
//    [tableViewController.navigationController pushViewController:detailVC animated:YES];
//    [tableViewController.tableView deselectRowAtIndexPath:[tableViewController.tableView indexPathForSelectedRow] animated:YES];
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    FeedItemCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    FeedItem *item = [self itemAtIndexPath:indexPath];
    
    // create subview to obscure the table view behind us
    
    // Set blurred view
    UIImage *blurred = [[AppDelegate sharedDelegate].window blurredSnapshot];
    self.blurredBG = [[UIImageView alloc] initWithImage:blurred];
    self.blurredBG.frame = [AppDelegate sharedDelegate].window.frame;
    [[AppDelegate sharedDelegate].window addSubview:self.blurredBG];
    
    detail = [[DetailViewController alloc] init];
    detail.feedItem = item;
    detail.view.frame = [AppDelegate sharedDelegate].window.frame;
    [[AppDelegate sharedDelegate].window addSubview:detail.view];
    
    self.back = [[UIButton alloc] initWithFrame:CGRectMake(4.0, 24.0, 28.0, 25.0)];
    [self.back setImage:[UIImage imageNamed:@"navbar_icon_back_card.png"] forState:UIControlStateNormal];
    [self.back addTarget:self action:@selector(dismissCard) forControlEvents:UIControlEventTouchUpInside];


    
    
    // move the cell's container view to the backdrop view, preserving its location on the screen
    // (so it doesn't look like it moved)
    
    //[cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    self.viewToMove = cell.containerView;
    cell.containerView.tableViewController = self.tableViewController;
    self.viewToMoveOriginalCell = cell;
    self.viewToMoveOriginalFrame = cell.containerView.frame;
    
    // figure out where this goes on the backdrop
    

    CGRect frame = [self.viewToMoveOriginalCell convertRect:cell.containerView.frame
                                                     toView:detail.view];
    
    // move it there (though it won't appear to move yet, we're just changing its superview)
    detail.scrollView.delegate = self;
    [detail setFeedItem:[self itemAtIndexPath:indexPath]];
    [detail setContainer:cell.containerView];
    self.viewToMove.frame = frame;
    
    // now do the animation
    
    [UIView animateWithDuration:0.10
                          delay:0.0
                        options:0.0
                     animations:^{
                         
                         // first shrinking it a bit
                         self.viewToMove.transform = CGAffineTransformMakeScale(0.95, 0.95);
                         
                         // Hide separater bar
                         cell.separatorLineView.hidden = YES;

                     }
                     completion:^(BOOL finished) {
                         
                         // finally restoring the size and making it bigger
                         // (and reveal the backdrop that obscures the tableview)
                         [detail.view addSubview:self.back];
                         //[detail.view insertSubview:self.back belowSubview:detail.scrollView];
                         
                         [UIView animateWithDuration:0.15 animations:^{
                             CGFloat horizontalMargin = (tableViewController.tableView.bounds.size.width - frame.size.width) / 2.0;
                             //detail.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
                             

                             self.viewToMove.transform = CGAffineTransformIdentity;
                             self.viewToMove.frame = CGRectMake(4, 60.0f, 312, self.viewToMove.frame.size.height);
                         } completion:^(BOOL finished) {
                             [self.viewToMove setBottomCornersStraight];
                             [detail setupViewDetails];
                         }];
                         
                         
                         self.viewToMove.userInteractionEnabled = YES;
                         [tableViewController addChildViewController:detail];
                         [detail didMoveToParentViewController:tableViewController];
                         detail.tableViewController = self.tableViewController;
                         
                         self.showingDetail = YES;
                     }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if (self.showingDetail && detail.scrollView.zoomScale == detail.scrollView.minimumZoomScale && translation.y > 150) {
        [self dismissCard];
    }
}

- (void)dismissCard
{
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:0
                     animations:^{
                         
                         [detail teardownViewDetails];
                         
                         // in case user scrolled in content view, scroll back
                         
                         //[self.viewToMove setContentOffset:CGPointZero animated:YES];
                         
                         // figure out where to resize view on container view so it's
                         // going to end up where it will end up in the cell

                         
                         
                         CGRect frame = [self.viewToMoveOriginalCell convertRect:self.viewToMoveOriginalFrame
                                                                          toView:detail.view];
                         self.viewToMove.frame = frame;
                         
                         // make the back drop appear to gracefully disappear
                         
                         [self.back removeFromSuperview];
                         //detail.view.backgroundColor = [UIColor clearColor];
                         [self.blurredBG removeFromSuperview];
                         
                         // Set all corners rounded
                         [self.viewToMove setAllCornersRounded];
                         
                         // Show separater bar
                         ((FeedItemCell*)self.viewToMoveOriginalCell).separatorLineView.hidden = NO;
                         
                         // shrink content view a tad in the process
                         
                         self.viewToMove.transform = CGAffineTransformMakeScale(0.95, 0.95);
                     }
                     completion:^(BOOL finished) {
                         
                         // when done with that animation ...
                         
                         [UIView animateWithDuration:0.10
                                               delay:0.0
                                             options:0
                                          animations:^{
                                              
                                              // restore the size of the content view
                                              
                                              self.viewToMove.transform = CGAffineTransformIdentity;
                                              
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              // when all done, put the content view back
                                              // in the cell
                                              
                                              [self.viewToMoveOriginalCell addSubview:self.viewToMove];
                                              self.viewToMove.frame = self.viewToMoveOriginalFrame;
                                              
                                              // Fix Border Color
                                              self.viewToMoveOriginalCell.contentView.backgroundColor = nil;

                                              
                                              // turn off its user interaction again 
                                              
                                              self.viewToMove.userInteractionEnabled = NO;
                                              
                                              // and now safely discard the backdrop
                                              
                                              [detail.view removeFromSuperview];
                                              self.showingDetail = NO;
                                          }];
                     }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    id <NSFetchedResultsSectionInfo> theSection = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    FeedSectionViewController *feedSectionVC = [[FeedSectionViewController alloc] initWithDateString:[theSection name]];
    //feedSectionVC.view.backgroundColor = [UIColor colorWithRed:121.00f green:159.00f blue:235.00f alpha:1];
    
    return feedSectionVC.view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row % 2 != 1)
        return kLCellSpacerHeight;
    
    static NSCache* heightCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        heightCache = [NSCache new];
    });
    
    NSAssert(heightCache, @"Height cache must exist");
    
    FeedItem *item = [self itemAtIndexPath:indexPath];
    Class cellClass = item.itemCellClass;
    
    NSString* key = item.identifier; //Create a unique key here
    NSNumber* cachedValue = [heightCache objectForKey: key];
    
    if( cachedValue )
        return [cachedValue floatValue];
    else {
        NSString *cellID = NSStringFromClass(cellClass);
        
        if (item.imageUrl) {
            cellID = [NSString stringWithFormat:@"%@-image",cellID];
        }
        
        if (item.user) {
            cellID = [NSString stringWithFormat:@"%@-user",cellID];
        }
        
        FeedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if ( !cell )
        {
            cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
        }
        
        // Configure the cell for this indexPath
        
        [cell configureForItem:item];
        
        
        // Make sure the constraints have been added to this cell, since it may have just been created from scratch
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        // Set the width of the cell to match the width of the table view. This is important so that we'll get the
        // correct height for different table view widths, since our cell's height depends on its width due to
        // the multi-line UILabel word wrapping. Don't need to do this above in -[tableView:cellForRowAtIndexPath]
        // because it happens automatically when the cell is used in the table view.
        cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
        
        // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
        // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
        // in the UITableViewCell subclass
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        // Get the actual height required for the cell
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        [heightCache setObject: [NSNumber numberWithFloat: height] forKey: key];
        
        return height;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 != 1)
        return kLCellSpacerHeight;
    return 200;
}



@end
