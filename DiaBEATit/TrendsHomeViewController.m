//
//  TrendsHomeViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "TrendsHomeViewController.h"
#import "SDSegmentedControl.h"


@interface TrendsHomeViewController ()
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentedControl;

@end

@implementation TrendsHomeViewController
@synthesize hostView = hostView_;

- (NSArray *)Systolic
{
    static NSMutableArray *Systolic = nil;
    if (!Systolic)
    {
        HypertensionLog *h = [[HypertensionLog alloc] init];
        Systolic = [h returnSystolicWithLogs:[h retrieveHypertensionLogsWithConstraints:@"WHERE systolic != '' AND diastolic != ''"]];
    }
    return Systolic;
}

- (NSArray *)Diastolic
{
    static NSArray *Diastolic = nil;
    if (!Diastolic)
    {
        HypertensionLog *h = [[HypertensionLog alloc] init];
        Diastolic = [h returnDiastolicWithLogs:[h retrieveHypertensionLogsWithConstraints:@"WHERE systolic != '' AND diastolic != ''"]];
    }
    return Diastolic;
}
- (NSArray *)Glucose
{
    static NSArray *Glucose = nil;
    if (!Glucose)
    {
        DiabetesLog *d = [[DiabetesLog alloc] init];
        Glucose = [d returnGlucoseWithLogs:[d retrieveDiabetesLogsWithConstraints:@"WHERE glucose != ''"]];
    }
    return Glucose;
}
- (NSArray *)HypertensionDates
{
    static NSArray *Dates = nil;
    if (!Dates)
    {
        HypertensionLog *h = [[HypertensionLog alloc] init];
        Dates = [h returnDatesWithLogs:[h retrieveHypertensionLogsWithConstraints:@"WHERE systolic != '' AND diastolic != ''"]];
    }
    NSLog(@"Exiting");
    return Dates;
}

- (NSArray *)DiabetesDates
{
    static NSArray *Dates = nil;
    if (!Dates)
    {
        DiabetesLog *d = [[DiabetesLog alloc] init];
        Dates = [d returnDatesWithLogs:[d retrieveDiabetesLogsWithConstraints:@"WHERE glucose != ''"]];
    }
    return Dates;
}

-(float)findMinimumPlot
{
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        float xmin = MAXFLOAT;
        for (NSNumber *num in self.Glucose)
        {
            float x = num.floatValue;
            if (x < xmin)
                xmin = x;
        }
        return xmin;
    }
    else
    {
        
        float xmin = MAXFLOAT;
        for (NSNumber *num in self.Diastolic)
        {
            float x = num.floatValue;
            if (x < xmin)
                xmin = x;
        }
        for (NSNumber *num in self.Systolic)
        {
            float x = num.floatValue;
            if (x < xmin)
                xmin = x;
        }
        return xmin;
        
        
    }
}

-(float)findMaximumPlot
{
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        NSLog(@"ENTERED");
        float xmax = 0.0;
        for (NSNumber *num in self.Glucose)
        {
            float x = num.floatValue;
            NSLog(@"Temp: %f", x);
            if (x > xmax)
                xmax = x;
        }
        return xmax;
    }
    else
    {
        
        float xmax = 0.0;
        for (NSNumber *num in self.Diastolic)
        {
            float x = num.floatValue;
            if (x > xmax)
                xmax = x;
        }
        for (NSNumber *num in self.Systolic)
        {
            float x = num.floatValue;
            if (x > xmax)
                xmax = x;
        }
        NSLog(@"Max: %f", xmax);
        return xmax;
    }
}



#pragma mark - UIViewController lifecycle methods
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initPlot];
}
-(IBAction) valueChanged: (id) sender{
    [self initPlot];
    
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {
    CGRect view = CGRectMake(0,
                             self.navigationController.navigationBar.frame.size.height + self.segmentedControl.frame.size.height + 30,
                             self.view.frame.size.width,
                             self.view.frame.size.height- self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height-self.segmentedControl.frame.size.height-30);
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:view];
    self.hostView.allowPinchScaling = YES;
    [self.view addSubview:self.hostView];
}

-(void)configureGraph {
    // 1 - Create the graph
    //self.navigationController.view.frame.size.height
    
    CGRect view = CGRectMake(0,
                             self.navigationController.navigationBar.frame.size.height + self.segmentedControl.frame.size.height + 30,
                             self.view.frame.size.width,
                             self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height- self.navigationController.navigationBar.frame.size.height-self.segmentedControl.frame.size.height-30);
    
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:view];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    self.hostView.hostedGraph = graph;
    // 2 - Set graph title
    NSString *title = @"";
    graph.title = title;
    // 3 - Create and set text style
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    // 4 - Set padding for plot area
    [graph.plotAreaFrame setPaddingLeft:30.0f];
    [graph.plotAreaFrame setPaddingBottom:30.0f];
    // 5 - Enable user interactions for plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots {
    // 1 - Get graph and plot space
    CPTGraph *graph = self.hostView.hostedGraph;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    // 2 - Create the three plots
    CPTScatterPlot *sysPlot = [[CPTScatterPlot alloc] init];
    sysPlot.dataSource = self;
    sysPlot.identifier = @"Systolic";
    CPTColor *sysColor = [CPTColor redColor];
    
    
    CPTScatterPlot *diaPlot = [[CPTScatterPlot alloc] init];
    diaPlot.dataSource = self;
    diaPlot.identifier = @"Diastolic";
    CPTColor *diaColor = [CPTColor greenColor];
    
    
    CPTScatterPlot *glucPlot = [[CPTScatterPlot alloc] init];
    glucPlot.identifier = @"Glucose";
    glucPlot.dataSource = self;
    CPTColor *glucColor = [CPTColor blueColor];
    
    
    if(self.segmentedControl.selectedSegmentIndex == 1)
    {
        [graph addPlot:diaPlot toPlotSpace:plotSpace];
        [graph addPlot:sysPlot toPlotSpace:plotSpace];
        // 3 - Set up plot space
        [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:sysPlot, diaPlot, nil]];
    }
    else
    {
        [graph addPlot:glucPlot toPlotSpace:plotSpace];
        // 3 - Set up plot space
        [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:glucPlot, nil]];
    }
    
    float xFactor;
    float yFactor;
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        xFactor = 1.4;
        yFactor = 1.8;
    }
    else
    {
        xFactor = 1.6;
        yFactor = 1.6;
    }
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(xFactor)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(yFactor)];
    //plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(500) length:CPTDecimalFromFloat(200)   ];
    plotSpace.yRange = yRange;
    
    
    if(self.segmentedControl.selectedSegmentIndex == 1)
    {
        CPTMutableLineStyle *sysLineStyle = [sysPlot.dataLineStyle mutableCopy];
        sysLineStyle.lineWidth = 1.0;
        sysLineStyle.lineColor = sysColor;
        sysPlot.dataLineStyle = sysLineStyle;
        CPTMutableLineStyle *sysSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        sysSymbolLineStyle.lineColor = sysColor;
        CPTPlotSymbol *sysSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        sysSymbol.fill = [CPTFill fillWithColor:sysColor];
        sysSymbol.lineStyle = sysSymbolLineStyle;
        sysSymbol.size = CGSizeMake(6.0f, 6.0f);
        sysPlot.plotSymbol = sysSymbol;
        CPTMutableLineStyle *diaLineStyle = [diaPlot.dataLineStyle mutableCopy];
        diaLineStyle.lineWidth = 1.0;
        diaLineStyle.lineColor = diaColor;
        diaPlot.dataLineStyle = diaLineStyle;
        CPTMutableLineStyle *diaSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        diaSymbolLineStyle.lineColor = diaColor;
        CPTPlotSymbol *diaSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        diaSymbol.fill = [CPTFill fillWithColor:diaColor];
        diaSymbol.lineStyle = diaSymbolLineStyle;
        diaSymbol.size = CGSizeMake(6.0f, 6.0f);
        diaPlot.plotSymbol = diaSymbol;
    }
    else
    {
        CPTMutableLineStyle *glucLineStyle = [glucPlot.dataLineStyle mutableCopy];
        glucLineStyle.lineWidth = 1.0;
        glucLineStyle.lineColor = glucColor;
        glucPlot.dataLineStyle = glucLineStyle;
        CPTMutableLineStyle *glucSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        glucSymbolLineStyle.lineColor = glucColor;
        CPTPlotSymbol *glucSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        glucSymbol.fill = [CPTFill fillWithColor:glucColor];
        glucSymbol.lineStyle = glucSymbolLineStyle;
        glucSymbol.size = CGSizeMake(6.0f, 6.0f);
        glucPlot.plotSymbol = glucSymbol;
    }
    
}
-(void)configureLegend {
    // 1 - Get graph instance
    CPTGraph *graph = self.hostView.hostedGraph;
    graph.legend = [CPTLegend legendWithGraph:graph];
    graph.legend.fill = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
    graph.legend.cornerRadius = 5.0;
    graph.legend.swatchSize = CGSizeMake(25.0, 25.0);
    graph.legendAnchor = CPTRectAnchorBottom;
    graph.legendDisplacement = CGPointMake(0.0, 12.0);
}

-(void)configureAxes {
    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 7.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    // 3 - Configure x-axis
    CPTAxis *x = axisSet.xAxis;
    x.title = @"";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 10.0f;
    
    
    x.tickDirection = CPTSignNegative;
    CGFloat dateCount;
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        dateCount = [self.DiabetesDates count];
    }
    else
    {
        dateCount = [self.HypertensionDates count];
    }
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
    NSInteger i = 1;
    
    NSArray *dates;
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        dates = self.DiabetesDates;
    }
    else
    {
        dates = self.HypertensionDates;
    }
    for (NSString *date in dates) {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
        CGFloat location = i++;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        
        
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    x.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(150.0f)];
    axisSet.xAxis.orthogonalCoordinateDecimal = CPTDecimalFromFloat(self.findMinimumPlot - 10);
    
    
    // 4 - Configure y-axis
    CPTAxis *y = axisSet.yAxis;
    if(self.segmentedControl.selectedSegmentIndex == 1)
        y.title = @"Blood Pressure (mmHg)";
    else
        y.title = @"Blood Sugar (mg/dL)";
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -20.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = -10.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    
    NSInteger majorIncrement = 5;
    NSInteger minorIncrement = 1;
    CGFloat yMax = self.findMaximumPlot;  // should determine dynamically based on max price
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        NSUInteger mod = j % majorIncrement;
        if (mod == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            if (label) {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        } else {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    y.axisLabels = yLabels;
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
    y.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(self.findMinimumPlot -10) length:CPTDecimalFromFloat(150.0f)];
    axisSet.yAxis.orthogonalCoordinateDecimal = CPTDecimalFromFloat(0);
    
    CPTGraph *graph = self.hostView.hostedGraph;
    graph.legend = [CPTLegend legendWithGraph:graph];
    graph.legend.fill = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
    graph.legend.cornerRadius = 5.0;
    graph.legend.swatchSize = CGSizeMake(25.0, 25.0);
    graph.legendAnchor = CPTRectAnchorBottom;
    graph.legendDisplacement = CGPointMake(0.0, 12.0);
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.segmentedControl.arrowHeightFactor *= -1.0;
    self.segmentedControl.scrollView.contentOffset = CGPointMake(0,65);
    self.segmentedControl.scrollView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    
    int i;
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        i = [self.DiabetesDates count];
        
    }
    else
    {
        i = [self.HypertensionDates count];
    }
    NSUInteger numberOfPlots = i;
    return numberOfPlots;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    int i;
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        i = [self.DiabetesDates count];
        
    }
    else
    {
        i = [self.HypertensionDates count];
    }
    NSInteger valueCount = i;
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
                return [NSNumber numberWithInteger:(index+1)];
                //return [self.Dates objectAtIndex:index];
            }
            break;
        case CPTScatterPlotFieldY:
            if(self.segmentedControl.selectedSegmentIndex == 1)
            {
                if ([plot.identifier isEqual:@"Systolic"] == YES)
                {
                    return [self.Systolic objectAtIndex:index];
                }
                else if ([plot.identifier isEqual:@"Diastolic"] == YES)
                {
                    return [self.Diastolic objectAtIndex:index];
                }
            }
            else
            {
                return [self.Glucose objectAtIndex:index];
            }
            break;
    }
    return [NSDecimalNumber zero];
}

@end
