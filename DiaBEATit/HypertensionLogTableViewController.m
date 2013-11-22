//
//  HypertensionLogTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "HypertensionLogTableViewController.h"
#import "HypertensionLog.h"
#import "EditHypertensionLogViewController.h"

@interface HypertensionLogTableViewController ()
@property (nonatomic,strong) HypertensionLog *log;
@property (weak, nonatomic) IBOutlet UILabel *systolicLabel;
@property (weak, nonatomic) IBOutlet UILabel *diastolicLabel;
@property (weak, nonatomic) IBOutlet UILabel *heartRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *logDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentsText;
@end

@implementation HypertensionLogTableViewController

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
}


-(void) viewWillAppear:(BOOL)animated {
    self.log = [[HypertensionLog alloc] init];
    self.log = [[self.log retrieveHypertensionLogsWithConstraints:[NSString stringWithFormat:@"WHERE id=%i",self.logId]] objectAtIndex:0];
    self.systolicLabel.text = self.log.systolic;
    self.diastolicLabel.text = self.log.diastolic;
    self.heartRateLabel.text = self.log.heartRate;
    if ([self.log.timeOfDay isEqualToString:@"0"]) {
        self.timeOfDayLabel.text = @"Morning";
    } else if ([self.log.timeOfDay isEqualToString:@"1"]) {
        self.timeOfDayLabel.text = @"Afternoon";
    } else {
        self.timeOfDayLabel.text = @"Night";
    }
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSDate* d = [df dateFromString:self.log.timestamp];
    
    [df setDateFormat:@"MMMM dd, yyyy"];
    NSString *dateString = [df stringFromDate:d];
    self.logDateLabel.text = dateString;
    self.commentsText.text = self.log.comments;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"editHypertensionLogSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        EditHypertensionLogViewController *controller = (EditHypertensionLogViewController *)navController.topViewController;
        controller.log = self.log;
    }
}


@end
