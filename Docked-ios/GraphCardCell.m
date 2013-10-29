//
//  GraphDataCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GraphCardCell.h"
#import "GraphItem.h"
#import "GraphDataSet.h"
#import "GraphDataDetail.h"

@interface GraphCardCell () <CPTPlotDataSource>

@end

@implementation GraphCardCell
{
    CPTGraphHostingView* hostView;
    CPTGraph *graph;
    UIImageView *graphImageView;
    NSArray *firstCoordinates;
    NSArray *secondCoordinates;
    NSArray *thirdCoordinates;
    UILabel *firstLabel;
    UILabel *firstData;
    UILabel *secondLabel;
    UILabel *secondData;
    UILabel *thirdLabel;
    UILabel *thirdData;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initChart];
        [self initBadges];
        
    }
    return self;
}

- (void)initChart {
    // We need a hostview, you can create one in IB (and create an outlet) or just do this:
    graphImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 300, 180)];
    [self.contentView addSubview: graphImageView];
    
    hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 64, 300, 180)];
    hostView.userInteractionEnabled = NO;
    
    // Create a CPTGraph object and add to hostView
    graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    hostView.hostedGraph = graph;
    graph.axisSet = nil;
    graph.paddingLeft = 4;
    graph.paddingRight = 4;
    
    [self initPlotSpaceWithIndex:[NSNumber numberWithInt:2]];
    [self initPlotSpaceWithIndex:[NSNumber numberWithInt:1]];
    [self initPlotSpaceWithIndex:0];
}

- (void) initPlotSpaceWithIndex:(NSNumber *)index
{
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = [[CPTXYPlotSpace alloc] init];
    plotSpace.allowsUserInteraction = FALSE;
    [graph addPlotSpace:plotSpace];
    
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 10 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 6 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    plot.identifier = [index stringValue];
    plot.dataSource = self;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor colorWithComponentRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:0.7f];
    plot.dataLineStyle = lineStyle;
    
    if(index == 0) {
        plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:0.7f]];
    } else if (index == [NSNumber numberWithInt:1]) {
        plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:179.0f/255.0f green:197.0f/255.0f  blue:227.0f/255.0f alpha:0.7f]];
    } else {
        plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:117.0f/255.0f green:220.0f/255.0f  blue:229.0f/255.0f alpha:0.7f]];
    }
    
    plot.areaBaseValue = CPTDecimalFromInteger(0);
    plot.interpolation = CPTScatterPlotInterpolationCurved;
    
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    graph.plotAreaFrame.masksToBorder = NO;
    [graph addPlot:plot toPlotSpace:plotSpace];
}

- (void) initBadges {
    firstLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [firstLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:10.0]];
    firstLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    firstLabel.text = @"Visits";
    [self.contentView addSubview: firstLabel];
    
    firstData = [[UILabel alloc] initWithFrame: CGRectZero];
    [firstData setFont: [UIFont fontWithName:@"Avenir-Light" size:20.0]];
    firstData.textColor = [[UIColor alloc] initWithRed:69.0f/255.0f green:69.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: firstData];
    
    secondLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [secondLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:10.0]];
    secondLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    secondLabel.text = @"Visitors";
    [self.contentView addSubview: secondLabel];
    
    secondData = [[UILabel alloc] initWithFrame: CGRectZero];
    [secondData setFont: [UIFont fontWithName:@"Avenir-Light" size:20.0]];
    secondData.textColor = [[UIColor alloc] initWithRed:69.0f/255.0f green:69.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: secondData];
    
    thirdLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [thirdLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:10.0]];
    thirdLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    thirdLabel.text = @"Pageviews";
    [self.contentView addSubview: thirdLabel];
    
    thirdData = [[UILabel alloc] initWithFrame: CGRectZero];
    [thirdData setFont: [UIFont fontWithName:@"Avenir-Light" size:20.0]];
    thirdData.textColor = [[UIColor alloc] initWithRed:69.0f/255.0f green:69.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: thirdData];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    firstLabel.frame = CGRectMake(24, 246, 100, 8);
    firstData.frame = CGRectMake(24, 254, 100, 20);
    
    secondLabel.frame = CGRectMake(132, 246, 100, 8);
    secondData.frame = CGRectMake(132, 254, 100, 20);
    
    
    thirdLabel.frame = CGRectMake(244, 246, 100, 8);
    thirdData.frame = CGRectMake(244, 254, 100, 20);
    
    [hostView setNeedsLayout];
    
}



#pragma mark - SChartDatasource methods

// Therefore this class implements the CPTPlotDataSource protocol
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    if (plotnumberOfRecords.identifier == 0) {
        return firstCoordinates.count;
    } else if (plotnumberOfRecords.identifier == [NSNumber numberWithInt:1]) {
        return secondCoordinates.count;
    } else {
       return thirdCoordinates.count;
    }
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if (plot.identifier == 0) {
        
        GraphDataDetail *detail = (GraphDataDetail *)firstCoordinates[index];
        // This method is actually called twice per point in the plot, one for the X and one for the Y value
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            // Return x value, which will, depending on index, be between -4 to 4
            return  detail.index;
        } else {
            // Return y value, for this example we'll be plotting y = x * x
            return detail.y;
        }
      } else if (plot.identifier == [NSNumber numberWithInt:1]) {
          GraphDataDetail *detail = (GraphDataDetail *)secondCoordinates[index];
          // This method is actually called twice per point in the plot, one for the X and one for the Y value
          if(fieldEnum == CPTScatterPlotFieldX)
          {
              // Return x value, which will, depending on index, be between -4 to 4
              return  detail.index;
          } else {
              // Return y value, for this example we'll be plotting y = x * x
              return detail.y;
          }

      } else {
          GraphDataDetail *detail = (GraphDataDetail *)thirdCoordinates[index];
          // This method is actually called twice per point in the plot, one for the X and one for the Y value
          if(fieldEnum == CPTScatterPlotFieldX)
          {
              // Return x value, which will, depending on index, be between -4 to 4
              return  detail.index;
          } else {
              // Return y value, for this example we'll be plotting y = x * x
              return detail.y;
          }

      }
}

- (void)configureForItem:(GraphItem *)item
{
    //id<GraphCardProtocol> graphCardItem = (id<GraphCardProtocol>)item;
    
    self.propertyLabel.text = item.property;
    self.actionLabel.text = item.action;
    self.bodyLabel.text = item.body;
    NSString *providerIconString = [NSString stringWithFormat:@"%@.png", item.provider];
    self.providerIconView.image = [UIImage imageNamed:providerIconString];
    self.timestampLabel.text = [item.timestamp timeAgo];
    
    // First Set
    GraphDataSet *firstSet = item.dataSets.firstObject;
    firstCoordinates = [firstSet.dataDetails array];
    firstData.text = [firstSet.totalDataCount stringValue];
    
    NSLog(@"%@", firstSet.maxYCount);
    
    // Second Set
    GraphDataSet *secondSet = item.dataSets[1];
    secondCoordinates = [secondSet.dataDetails array];
    secondData.text = [secondSet.totalDataCount stringValue];
    
    // Third Set
    GraphDataSet *thirdSet = item.dataSets[2];
    thirdCoordinates = [thirdSet.dataDetails array];
    thirdData.text = [thirdSet.totalDataCount stringValue];

    
    
//    firstCoordinates = graphCardItem.firstCoordinates;
//    secondCoordinates = graphCardItem.secondCoordinates;
//    thirdCoordinates = graphCardItem.thirdCoordinates;
//    
//    
//    firstData.text = [graphCardItem.firstDataField stringValue];
//    secondData.text = [graphCardItem.secondDataField stringValue];
//    thirdData.text = [graphCardItem.thirdDataField stringValue];
//    
    static NSCache* imageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [NSCache new];
    });
    
    NSAssert(imageCache, @"Height cache must exist");
    
    NSString* key = item.externalID; //Create a unique key here
    UIImage* cachedValue = [imageCache objectForKey: key];
    
    if( cachedValue )
       [graphImageView setImage:cachedValue];
    else {
        
        // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
        [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 )
                                                           length:CPTDecimalFromFloat([firstSet.maxYCount floatValue] )]];
        
        [graph reloadData];
        UIImage *newImage=[graph imageOfLayer];
        [imageCache setObject:newImage forKey:key];
        [graphImageView setImage:newImage];
    }
}

+ (CGFloat) estimatedHeightOfContent
{
    return 290;
}

+ (CGFloat) heightOfContent: (FeedItem *)item {
    return 290;
}

@end
