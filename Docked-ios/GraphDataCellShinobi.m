//
//  GraphDataCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GraphDataCellShinobi.h"
#import <ShinobiCharts/ShinobiChart.h>

@interface GraphDataCellShinobi () <SChartDatasource>

@end

@implementation GraphDataCellShinobi
{
    ShinobiChart* _chart;
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
    _chart = [[ShinobiChart alloc] initWithFrame:CGRectZero];
    
    //_chart.autoresizingMask =  ~UIViewAutoresizingNone;
    
    _chart.licenseKey = @"YckzPtDz4NAkrOiMjAxMzExMDFpbmZvQHNoaW5vYmljb250cm9scy5jb20=bKW4TvDFZX6P8P7sETLeGBeEzXUmqsgFX/7akg80bGLEjPIJja1IA0h7xTZQpoGGrzwh8ETi7sIHuQ3ddIb9S3ZDUtKchbQ9sEF1Gb0N2PTYJ4nExBsq0EKNXwPLokYH9BUqNKNLlUDA6KbTSjGuQsWffJ1k=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
    
    // add a pair of axes
    SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
    xAxis.style.majorTickStyle.showLabels = NO;
    xAxis.style.majorTickStyle.showTicks = NO;
    xAxis.style.lineWidth = @0.5f;
    xAxis.width = @1.f;
    _chart.xAxis = xAxis;
    
    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    xAxis.style.majorTickStyle.showLabels = NO;
    yAxis.style.majorTickStyle.showTicks = NO;
    yAxis.style.lineWidth = @0.5f;
    yAxis.width = @1.f;
    yAxis.rangePaddingLow = @(0.5);
    yAxis.rangePaddingHigh = @(0.5);
    yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    yAxis.style.interSeriesPadding  = [NSNumber numberWithInt:1];
    _chart.yAxis = yAxis;
    
    _chart.datasource = self;
    _chart.legend.hidden = YES;
    _chart.userInteractionEnabled = NO;
    
    [self.contentView addSubview:_chart];
}

- (void) initBadges {
    firstLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [firstLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:8.0]];
    firstLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    firstLabel.text = @"Visits";
    [self.contentView addSubview: firstLabel];
    
    firstData = [[UILabel alloc] initWithFrame: CGRectZero];
    [firstData setFont: [UIFont fontWithName:@"Avenir-Light" size:18.0]];
    firstData.textColor = [[UIColor alloc] initWithRed:69.0f/255.0f green:69.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: firstData];
    
    secondLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [secondLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:8.0]];
    secondLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    secondLabel.text = @"Visitors";
    [self.contentView addSubview: secondLabel];
    
    secondData = [[UILabel alloc] initWithFrame: CGRectZero];
    [secondData setFont: [UIFont fontWithName:@"Avenir-Light" size:18.0]];
    secondData.textColor = [[UIColor alloc] initWithRed:69.0f/255.0f green:69.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: secondData];
    
    thirdLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [thirdLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:8.0]];
    thirdLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    thirdLabel.text = @"Pageviews";
    [self.contentView addSubview: thirdLabel];
    
    thirdData = [[UILabel alloc] initWithFrame: CGRectZero];
    [thirdData setFont: [UIFont fontWithName:@"Avenir-Light" size:18.0]];
    thirdData.textColor = [[UIColor alloc] initWithRed:69.0f/255.0f green:69.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
    [self.contentView addSubview: thirdData];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    _chart.frame = CGRectInset(CGRectMake(0, 60, 308, 180), 0, 0); //;
    firstLabel.frame = CGRectMake(20, 240, 100, 10);
    firstData.frame = CGRectMake(20, 252, 100, 20);
    
    secondLabel.frame = CGRectMake(122, 240, 100, 10);
    secondData.frame = CGRectMake(122, 252, 100, 20);
    
    
    thirdLabel.frame = CGRectMake(224, 240, 100, 10);
    thirdData.frame = CGRectMake(224, 252, 100, 20);
}



#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    
    SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
    lineSeries.style.lineColor = [[UIColor alloc] initWithRed:32.0f/255.0f green:203.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    lineSeries.style.lineWidth = [NSNumber numberWithInt:2];
    //lineSeries.style.fillWithGradient = YES;
    lineSeries.style.areaLineColor = [[UIColor alloc] initWithRed:32.0f/255.0f green:203.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    lineSeries.style.areaColorLowGradient = [[UIColor alloc] initWithRed:32.0f/255.0f green:203.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    lineSeries.style.areaColor = [[UIColor alloc] initWithRed:32.0f/255.0f green:203.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    lineSeries.style.showFill = YES;
    
    lineSeries.style.pointStyle.showPoints = NO;
    //lineSeries.style.pointStyle.color = [UIColor orangeColor];
    //lineSeries.style.pointStyle.innerColor = [UIColor orangeColor];
    //lineSeries.style.pointStyle.innerRadius = [NSNumber numberWithInt:0];
    
    // the first series is a cosine curve, the second is a sine curve
    
    return lineSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    return chartCoordinates.count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    
    SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    
    datapoint.xValue = [NSNumber numberWithInteger:dataIndex];
    datapoint.yValue = chartCoordinates[dataIndex];
    
    return datapoint;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
