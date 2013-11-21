///Users/appjam/Downloads/DiaBEATit-master/DiaBEATit.xcodeproj
//  TrendsHomeViewController.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "HypertensionLog.h"
#import "DiabetesLog.h"


@interface TrendsHomeViewController : UIViewController
<CPTPlotDataSource, UIActionSheetDelegate>
@property (nonatomic, strong) CPTGraphHostingView *hostView;
- (NSArray *)Systolic;
- (NSArray *)Diastolic;
- (NSArray *)Glucose;
- (NSArray *)HypertensionDates;
- (NSArray *)DiabetesDates;
- (float) findMinimumPlot;
- (float) findMaximumPlot;
@end
