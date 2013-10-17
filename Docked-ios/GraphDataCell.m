//
//  GraphDataCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GraphDataCell.h"

@interface GraphDataCell () <CPTPlotDataSource>

@end

@implementation GraphDataCell
{
    CPTGraphHostingView* hostView;
    CPTGraph *graph;
    NSArray *chartCoordinates;
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
    hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectInset(CGRectMake(0, 70, 308, 180), 0, 0)];
    [self.contentView addSubview: hostView];
    hostView.userInteractionEnabled = NO;

    
    // Create a CPTGraph object and add to hostView
    graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    hostView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = FALSE;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 10 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 6 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot.dataSource = self;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor colorWithComponentRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:0.7f];
    plot.dataLineStyle = lineStyle;
    plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:0.7f]];
    plot.areaBaseValue = CPTDecimalFromInteger(0);
    plot.interpolation = CPTScatterPlotInterpolationCurved;

    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    graph.plotAreaFrame.masksToBorder = NO;
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
    
    graph.axisSet = nil;
    
   
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
    firstLabel.frame = CGRectMake(24, 240, 100, 10);
    firstData.frame = CGRectMake(24, 252, 100, 20);
    
    secondLabel.frame = CGRectMake(132, 240, 100, 10);
    secondData.frame = CGRectMake(132, 252, 100, 20);
    
    
    thirdLabel.frame = CGRectMake(244, 240, 100, 10);
    thirdData.frame = CGRectMake(244, 252, 100, 20);
    
    [hostView setNeedsLayout];
    
}



#pragma mark - SChartDatasource methods

// Therefore this class implements the CPTPlotDataSource protocol
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    return chartCoordinates.count;
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        return [NSNumber numberWithInteger:index];
    } else {
        // Return y value, for this example we'll be plotting y = x * x
        return chartCoordinates[index];
    }
}

- (void)configureForItem:(FeedItem *)item
{
    id<GraphCardProtocol> graphCardItem = (id<GraphCardProtocol>)item;
    
    self.propertyLabel.text = graphCardItem.property;
    self.actionLabel.text = graphCardItem.action;
    self.bodyLabel.text = graphCardItem.body;
    self.providerIconView.image = graphCardItem.providerIcon;
    self.timestampLabel.text = [graphCardItem.timestamp timeAgo];
    
    chartCoordinates = graphCardItem.chartCoordinates;
    
    firstData.text = [graphCardItem.firstDataField stringValue];
    secondData.text = [graphCardItem.secondDataField stringValue];
    thirdData.text = [graphCardItem.thirdDataField stringValue];
}

+ (CGFloat) estimatedHeightOfContent
{
    return 290;
}

+ (CGFloat) heightOfContent: (FeedItem *)item {
    return 290;
}

@end
