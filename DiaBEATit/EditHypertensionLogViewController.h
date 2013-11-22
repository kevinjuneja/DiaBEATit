//
//  EditHypertensionLogViewController.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HypertensionLog.h"

@interface EditHypertensionLogViewController : UITableViewController
@property (nonatomic) int timeOfDay;
@property (nonatomic, strong) HypertensionLog *log;
@end
