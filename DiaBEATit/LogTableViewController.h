//
//  LogTableViewController.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *logs;
@property (nonatomic) int type;
@property (nonatomic, strong) NSArray *logGroups;
@end
