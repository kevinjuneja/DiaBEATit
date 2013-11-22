//
//  EditDiabetesLogViewController.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiabetesLog.h"

@interface EditDiabetesLogViewController : UITableViewController
@property (nonatomic) int timeOfDay;
@property (nonatomic) int mealTiming;
@property (nonatomic, strong) DiabetesLog *log;
@end
