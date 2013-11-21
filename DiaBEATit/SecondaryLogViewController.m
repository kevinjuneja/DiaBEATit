//
//  SecondaryLogViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "SecondaryLogViewController.h"
#import "AddDiabetesLogTableViewController.h"

@interface SecondaryLogViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cell1Label;
@property (weak, nonatomic) IBOutlet UILabel *cell2Label;
@property (weak, nonatomic) IBOutlet UILabel *cell3Label;

@property (strong, nonatomic) NSArray *labels;
@property (nonatomic) NSInteger type;

@property (nonatomic) NSInteger selectedRow;
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
    
}

-(void) viewWillDisappear:(BOOL)animated {
    int currentVCIndex = [self.navigationController.viewControllers indexOfObject:self.navigationController.topViewController];
    
    AddDiabetesLogTableViewController *parent = (AddDiabetesLogTableViewController *)[self.navigationController.viewControllers objectAtIndex:currentVCIndex];
    
    if (self.type == 0) {
        parent.timeOfDay = self.selectedRow;
    } else {
        parent.mealTiming = self.selectedRow;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setLabelsFromStrings:(NSArray *)strings andTypeWithInt:(NSInteger)type {
    self.labels = strings;
    self.type = type;
}


- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    self.selectedRow = indexPath.row;
    [tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];

}


@end
