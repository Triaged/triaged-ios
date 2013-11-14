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
    UIButton *showFirstGraphButton;
    UIButton *showSecondGraphButton;
    UIButton *showThirdGraphButton;
    CPTMutableTextStyle *labelTextStyle;
    
    float maxYValue;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initChart];
        [self initBadges];
        
        self.shouldCache = YES;
        
    }
    return self;
}

- (void)initChart {
    // We need a hostview, you can create one in IB (and create an outlet) or just do this:
    graphImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 304, 180)];
    
    hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 80, 304, 180)];
    hostView.userInteractionEnabled = NO;
    
    
    // Create a CPTGraph object and add to hostView
    graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    hostView.hostedGraph = graph;
    
    graph.paddingLeft = 0;
    graph.paddingRight = 0;
    graph.plotAreaFrame.paddingLeft   = 6.0;
    graph.plotAreaFrame.paddingRight  = 6.0;
    
    [self initPlotSpaceWithIndex:[NSNumber numberWithInt:2]];
    [self initPlotSpaceWithIndex:[NSNumber numberWithInt:1]];
    [self initPlotSpaceWithIndex:[NSNumber numberWithInt:0]];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    labelTextStyle = [[ CPTMutableTextStyle alloc] init];
    labelTextStyle.fontName = @"Avenir-Roman";
    labelTextStyle.fontSize = 9;
    labelTextStyle.color =    [CPTColor colorWithComponentRed:197.0f/255.0f green:208.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    
    
    // X Axis
    CPTXYAxis *x = axisSet.xAxis;
    x.hidden = YES;
    //x.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
//    NSSet *labelPositions = [[NSSet alloc] initWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:1.1],[NSNumber numberWithFloat:2.0],[NSNumber numberWithFloat:3.0],[NSNumber numberWithFloat:4.0],[NSNumber numberWithFloat:5.0],[NSNumber numberWithFloat:6], nil];
    x.labelOffset = -3;
    x.labelTextStyle = labelTextStyle;
    //x.labelingPolicy = CPTAxisLabelingPolicyLocationsProvided;
    //[x setMajorTickLocations:labelPositions];
    x.preferredNumberOfMajorTicks = 7;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.dateFormat = @"EEEEE";
    CPTCalendarFormatter *calendarFormatter = [[CPTCalendarFormatter
                                                alloc] initWithDateFormatter:dateFormatter];
    calendarFormatter.referenceCalendarUnit = NSDayCalendarUnit;
    x.labelFormatter = calendarFormatter;
    x.labelAlignment = CPTAlignmentCenter;
    
    // Y Axis
    CPTMutableLineStyle *majorYGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorYGridLineStyle.lineWidth = .5f;
    majorYGridLineStyle.dashPattern =  CPTLinearBlendingMode;
    majorYGridLineStyle.lineColor = [CPTColor colorWithComponentRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0];
    axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.yAxis.majorGridLineStyle = majorYGridLineStyle;
    axisSet.yAxis.hidden = YES;
    
}

- (void) initPlotSpaceWithIndex:(NSNumber *)index
{
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = [[CPTXYPlotSpace alloc] init];
    plotSpace.allowsUserInteraction = FALSE;
    plotSpace.identifier = [index stringValue];
    [graph addPlotSpace:plotSpace];
    
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 14 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromString(@"0") length:CPTDecimalFromString(@"6")]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    plot.identifier = [index stringValue];
    plot.dataSource = self;
    plot.delegate = self;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    
    
    if([index intValue] == 0) {
        plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:0.7f]];
        lineStyle.lineColor = [CPTColor colorWithComponentRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:0.7f];
        plot.dataLineStyle = lineStyle;
    } else if ([index intValue] == 1) {
        plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:179.0f/255.0f green:197.0f/255.0f  blue:227.0f/255.0f alpha:0.7f]];
        lineStyle.lineColor = [CPTColor colorWithComponentRed:179.0f/255.0f green:197.0f/255.0f  blue:227.0f/255.0f alpha:0.7f];
        plot.dataLineStyle = lineStyle;
    } else {
        plot.areaFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:117.0f/255.0f green:220.0f/255.0f  blue:229.0f/255.0f alpha:0.7f]];
        lineStyle.lineColor = [CPTColor colorWithComponentRed:117.0f/255.0f green:220.0f/255.0f  blue:229.0f/255.0f alpha:0.7f];
        plot.dataLineStyle = lineStyle;
    }
    
    plot.areaBaseValue = CPTDecimalFromInteger(0);
    plot.interpolation = CPTScatterPlotInterpolationCurved;
    
    
    
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    graph.plotAreaFrame.masksToBorder = NO;
    [graph addPlot:plot toPlotSpace:plotSpace];
}

- (void) initBadges {
    firstLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [firstLabel setFont: [UIFont fontWithName:@"Avenir-Heavy" size:8.0]];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.textColor = [[UIColor alloc] initWithRed:32.0f/255.0f green:203.0f/255.0f  blue:133.0f/255.0f alpha:1.0f];
    firstLabel.text = @"VISITORS";
    [self.contentView addSubview: firstLabel];
    
    firstData = [[UILabel alloc] initWithFrame: CGRectZero];
    [firstData setFont: [UIFont fontWithName:@"Avenir-Medium" size:16.0]];
    firstData.textAlignment = NSTextAlignmentCenter;
    firstData.textColor = [[UIColor alloc] initWithRed:40.0f/255.0f green:47.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: firstData];
    
    secondLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [secondLabel setFont: [UIFont fontWithName:@"Avenir-Heavy" size:8.0]];
    secondLabel.textColor = [[UIColor alloc] initWithRed:179.0f/255.0f green:197.0f/255.0f  blue:227.0f/255.0f alpha:1.0f];
    secondLabel.text = @"VISITS";
    [self.contentView addSubview: secondLabel];
    
    secondData = [[UILabel alloc] initWithFrame: CGRectZero];
    [secondData setFont: [UIFont fontWithName:@"Avenir-Medium" size:16.0]];
    secondData.textAlignment = NSTextAlignmentCenter;
    secondData.textColor = [[UIColor alloc] initWithRed:40.0f/255.0f green:47.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: secondData];
    
    thirdLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    [thirdLabel setFont: [UIFont fontWithName:@"Avenir-Heavy" size:8.0]];
    thirdLabel.textColor = [[UIColor alloc] initWithRed:117.0f/255.0f green:220.0f/255.0f  blue:229.0f/255.0f alpha:1.0f];
    thirdLabel.text = @"PAGEVIEWS";
    [self.contentView addSubview: thirdLabel];
    
    thirdData = [[UILabel alloc] initWithFrame: CGRectZero];
    thirdData.textAlignment = NSTextAlignmentCenter;
    [thirdData setFont: [UIFont fontWithName:@"Avenir-Medium" size:16.0]];
    thirdData.textColor = [[UIColor alloc] initWithRed:40.0f/255.0f green:47.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: thirdData];
    
    showFirstGraphButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 260, 101, 50)];
    showFirstGraphButton.backgroundColor = [UIColor clearColor];
    [showFirstGraphButton addTarget:self action:@selector(showFirstPlotSpace) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:showFirstGraphButton];
    
    showSecondGraphButton = [[UIButton alloc] initWithFrame: CGRectMake(101, 260, 101, 50)];
    showSecondGraphButton.backgroundColor = [UIColor clearColor];
    [showSecondGraphButton addTarget:self action:@selector(showSecondPlotSpace) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:showSecondGraphButton];
    
    showThirdGraphButton = [[UIButton alloc] initWithFrame: CGRectMake(202, 260, 101, 50)];
    showThirdGraphButton.backgroundColor = [UIColor clearColor];
    [showThirdGraphButton addTarget:self action:@selector(showThirdPlotSpace) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:showThirdGraphButton];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    firstLabel.frame = CGRectMake(0, 290, 101, 12);
    firstData.frame = CGRectMake(0, 270, 101, 20);
    
    secondLabel.frame = CGRectMake(101, 290, 101, 12);
    secondData.frame = CGRectMake(101, 270, 101, 20);
    
    
    thirdLabel.frame = CGRectMake(202, 290, 101, 12);
    thirdData.frame = CGRectMake(202, 270, 101, 20);
    
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
    if ([plot.identifier isEqual:@"0"]) {
        
        GraphDataDetail *detail = (GraphDataDetail *)firstCoordinates[index];
        // This method is actually called twice per point in the plot, one for the X and one for the Y value
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            // Return x value, which will, depending on index, be between -4 to 4
            return [NSNumber numberWithInteger:index];
        } else {
            // Return y value, for this example we'll be plotting y = x * x
            //NSLog(@"Index: %lu, Value: %@", (unsigned long)index, detail.y);
            return detail.y;
        }
      } else if ([plot.identifier isEqual:@"1"]) {
          GraphDataDetail *detail = (GraphDataDetail *)secondCoordinates[index];
          // This method is actually called twice per point in the plot, one for the X and one for the Y value
          if(fieldEnum == CPTScatterPlotFieldX)
          {
              // Return x value, which will, depending on index, be between -4 to 4
              return [NSNumber numberWithInteger:index];
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
              return [NSNumber numberWithInteger:index];
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
    self.bodyLabel.text = @""; //item.body;
    NSString *providerIconString = [NSString stringWithFormat:@"%@.png", item.provider];
    self.providerIconView.image = [UIImage imageNamed:providerIconString];
    self.timestampLabel.text = [item.timestamp timeAgo];
    
    // First Set
    GraphDataSet *firstSet = item.dataSets.firstObject;
    firstCoordinates = [firstSet.dataDetails array];
    firstData.text = [firstSet.totalDataCount stringValue];
    maxYValue = [firstSet.maxYCount floatValue];
    
     // Second Set
    if (item.dataSets.count > 1) {
        UIImage *line = [UIImage imageNamed:@"line_graph.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:line];
        lineView.frame = CGRectMake(100, 274, 1, 26);
        [self.contentView addSubview:lineView];
        
        GraphDataSet *secondSet = item.dataSets[1];
        secondCoordinates = [secondSet.dataDetails array];
        secondData.text = [secondSet.totalDataCount stringValue];
        if ([secondSet.maxYCount floatValue] > maxYValue) maxYValue = [secondSet.maxYCount floatValue];
    }
    
     // Third Set
    if (item.dataSets.count > 2) {
        UIImage *line = [UIImage imageNamed:@"line_graph.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:line];
        lineView.frame = CGRectMake(200, 274, 1, 26);
        [self.contentView addSubview:lineView];
       
        GraphDataSet *thirdSet = item.dataSets[2];
        thirdCoordinates = [thirdSet.dataDetails array];
        thirdData.text = [thirdSet.totalDataCount stringValue];
        if ([thirdSet.maxYCount floatValue] > maxYValue) maxYValue = [thirdSet.maxYCount floatValue];
    }
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( maxYValue)]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromString(@"0") length:CPTDecimalFromString(@"6")]];
    
    [self configureAxis:item.timestamp];
    [graph reloadData];
    
    if (!self.shouldCache) {
        [self.contentView addSubview:hostView];
        
        showFirstGraphButton.enabled = YES;
        showSecondGraphButton.enabled = YES;
        showThirdGraphButton.enabled = YES;
        
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
        axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    
    } else {
        static NSCache* imageCache = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            imageCache = [NSCache new];
        });
        
        NSAssert(imageCache, @"Height cache must exist");
        
        NSString* key = item.externalID; //Create a unique key here
        UIImage* cachedValue = [imageCache objectForKey: key];
        
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
        axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;

        
        if( cachedValue )
            [graphImageView setImage:cachedValue];
        else {
            
            UIImage *newImage=[graph imageOfLayer];
            [imageCache setObject:newImage forKey:key];
            [graphImageView setImage:newImage];
            [self.contentView addSubview: graphImageView];
        }
        
        showFirstGraphButton.enabled = NO;
        showSecondGraphButton.enabled = NO;
        showThirdGraphButton.enabled = NO;

    }
}



- (void) configureAxis:(NSDate *)referenceDate {
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    // X Axis
    CPTCalendarFormatter *calendarFormatter = (CPTCalendarFormatter *)axisSet.xAxis.labelFormatter;
    calendarFormatter.referenceDate = referenceDate;
    axisSet.xAxis.labelFormatter = calendarFormatter;
    
    //[axisSet.yAxis setNeedsRelabel];
    [axisSet.xAxis setNeedsRelabel];
    
    // Y Axis
    
    // Top Label
    NSString *maxYString = [NSString stringWithFormat:@"%.0f", maxYValue];
    CPTAxisLabel *topLabel = [[CPTAxisLabel alloc] initWithText:maxYString textStyle:labelTextStyle];
    float maxTickLocation = maxYValue - (maxYValue * .06);
    topLabel.tickLocation = [[NSNumber numberWithFloat:maxTickLocation] decimalValue];
    topLabel.offset = (topLabel.contentLayer.frame.size.width * -0.5);
    
    // Mid Label
    NSString *midYString = [NSString stringWithFormat:@"%.0f", (maxYValue / 2)];
    CPTAxisLabel *midLabel = [[CPTAxisLabel alloc] initWithText:midYString textStyle:labelTextStyle];
    float midTickLocation = (maxYValue / 2) - (maxYValue * .06);
    midLabel.tickLocation = [[NSNumber numberWithFloat:midTickLocation] decimalValue];
    midLabel.offset = (midLabel.contentLayer.frame.size.width * -0.5);
    
    
    axisSet.yAxis.axisLabels = [NSSet setWithObjects:topLabel, midLabel, nil];
    
    // Grid Lines
    float spacer = maxYValue / 4.0f;
    NSNumber *tick1 = [NSNumber numberWithFloat:(spacer)];
    NSNumber *tick2 = [NSNumber numberWithFloat:(spacer * 2)];
    NSNumber *tick3 = [NSNumber numberWithFloat:(spacer * 3)];
    NSNumber *tick4 = [NSNumber numberWithFloat:maxYValue];
    axisSet.yAxis.majorTickLocations = [NSSet setWithObjects:tick1, tick2, tick3, tick4, nil];
}

+ (CGFloat) estimatedHeightOfContent
{
    return 320;
}

+ (CGFloat) heightOfContent: (FeedItem *)item {
    return 320;
}

#pragma mark Animations

-(void) showFirstPlotSpace {
    [self showPlotSpaceWithIndex:@"0"];
}

-(void) showSecondPlotSpace {
    [self showPlotSpaceWithIndex:@"1"];
}

-(void) showThirdPlotSpace {
    [self showPlotSpaceWithIndex:@"2"];
}


- (void) hidePlot:(CPTScatterPlot *) plot {
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.duration = 0.5f;
    fadeOutAnimation.removedOnCompletion = NO;
    fadeOutAnimation.fillMode = kCAFillModeForwards;
    fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    fadeOutAnimation.delegate = self;
    [fadeOutAnimation setValue:(NSString *)plot.identifier forKey:@"id"];
    [fadeOutAnimation setValue:@"fadeout" forKey:@"type"];
    [plot addAnimation:fadeOutAnimation forKey:@"animateOpacity"];
}

- (void) showPlotSpaceWithIndex:(NSString *)index
{
    NSArray *plots = [graph allPlots];
    for (CPTScatterPlot* plot in plots) {
        if (![plot.identifier isEqual:index]) {
            [self hidePlot:plot];
        }
    }
    
    CPTScatterPlot* plot = (CPTScatterPlot*)[graph plotWithIdentifier:index];
    
    if (plot.hidden == YES) {
        CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeInAnimation.duration            = 0.5f;
        fadeInAnimation.removedOnCompletion = NO;
        fadeInAnimation.fillMode            = kCAFillModeForwards;
        fadeInAnimation.toValue             = [NSNumber numberWithFloat:1.0];
        fadeInAnimation.delegate = self;
        [fadeInAnimation setValue:@"fadein" forKey:@"type"];
        [fadeInAnimation setValue:(NSString *)plot.identifier forKey:@"id"];
        [plot addAnimation:fadeInAnimation forKey:@"fadein"];
        
        plot.hidden = NO;
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    CPTScatterPlot* plot = (CPTScatterPlot*)[graph plotWithIdentifier:[theAnimation valueForKey:@"id"]];
    if ([[theAnimation valueForKey:@"type"] isEqual:@"fadeout"]) {
        plot.hidden = YES;
    } else {
        plot.hidden = NO;
    }
}

@end
