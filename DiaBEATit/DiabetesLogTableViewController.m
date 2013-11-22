//
//  DiabetesLogTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "DiabetesLogTableViewController.h"
#import "EditDiabetesLogViewController.h"

@interface DiabetesLogTableViewController () 
@property (nonatomic, strong) DiabetesLog *log;
@property (weak, nonatomic) IBOutlet UILabel *glucoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *insulinLabel;
@property (weak, nonatomic) IBOutlet UILabel *a1cLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealTimingLabel;
@property (weak, nonatomic) IBOutlet UILabel *logDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentsText;
@end

@implementation DiabetesLogTableViewController

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
    self.log = [[DiabetesLog alloc] init];
    self.log = [[self.log retrieveDiabetesLogsWithConstraints:[NSString stringWithFormat:@"WHERE id=%i",self.logId]] objectAtIndex:0];
    self.glucoseLabel.text = self.log.glucose;
    self.insulinLabel.text = self.log.insulin;
    if (self.log.a1c.length > 0) {
        self.a1cLabel.text = self.log.a1c;
    } else {
        self.a1cLabel.text = @"Not logged";
    }
    if ([self.log.timeOfDay isEqualToString:@"0"]) {
        self.timeOfDayLabel.text = @"Morning";
    } else if ([self.log.timeOfDay isEqualToString:@"1"]) {
        self.timeOfDayLabel.text = @"Afternoon";
    } else {
        self.timeOfDayLabel.text = @"Night";
    }
    if ([self.log.mealTiming isEqualToString:@"0"]) {
        self.mealTimingLabel.text = @"Before Meal";
    } else if ([self.log.mealTiming isEqualToString:@"1"]) {
        self.mealTimingLabel.text = @"After Meal";
    } else {
        self.mealTimingLabel.text = @"No Meal";
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
    if([segue.identifier isEqualToString:@"editDiabetesLogSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        EditDiabetesLogViewController *controller = (EditDiabetesLogViewController *)navController.topViewController;
        controller.log = self.log;
    }
}

@end
