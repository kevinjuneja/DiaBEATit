//
//  SecondaryLogViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "SecondaryLogViewController.h"

@interface SecondaryLogViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cell1Label;
@property (weak, nonatomic) IBOutlet UILabel *cell2Label;
@property (weak, nonatomic) IBOutlet UILabel *cell3Label;

@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSString *type;
@end

@implementation SecondaryLogViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.cell1Label.text = [self.labels objectAtIndex:0];
    self.cell2Label.text = [self.labels objectAtIndex:1];
    self.cell3Label.text = [self.labels objectAtIndex:2];
    
    [self.tableView
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setLabelsFromStrings:(NSArray *)strings andTypeWithString:(NSString *)type {
    self.labels = strings;
    self.type = type;
}



@end
