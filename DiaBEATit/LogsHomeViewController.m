//
//  LogsHomeViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/16/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "LogsHomeViewController.h"
#import "SDSegmentedControl.h"
#import "DiabetesLog.h"
#import "HypertensionLog.h"
#import "LogTableViewController.h"

@interface LogsHomeViewController ()
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentedControl;
@property (strong, nonatomic) NSString *segueId;
@property (strong, nonatomic) LogTableViewController *logTable;

@property (strong, nonatomic) NSArray *logs;
@property (strong, nonatomic) DiabetesLog *dLog;
@property (strong, nonatomic) HypertensionLog *hLog;

@property (nonatomic) NSInteger segmentIndex;
@end

@implementation LogsHomeViewController

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
//    self.segmentedControl.arrowHeightFactor *= -1.0;
    self.segmentedControl.scrollView.scrollEnabled = NO;

    self.dLog = [[DiabetesLog alloc] init];
    self.hLog = [[HypertensionLog alloc] init];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [self.segmentedControl.scrollView setContentOffset:CGPointMake(0,64) animated:YES];
    self.segmentIndex = self.segmentedControl.selectedSegmentIndex;
    
    if (self.segmentIndex == 0) {
        self.logTable.logs = [self.dLog retrieveDiabetesLogs];
        if ([self.logTable.logs count] > 0) {
            self.logTable.logGroups = [self.dLog returnGroupingsWithLogs:self.logTable.logs];
        }
        self.logTable.type = 0;
    } else {
        self.logTable.logs = [self.hLog retrieveHypertensionLogs];
        if ([self.logTable.logs count] > 0) {
            self.logTable.logGroups = [self.hLog returnGroupingsWithLogs:self.logTable.logs];
        }
        self.logTable.type = 1;
    }
    [self.logTable.tableView reloadData];

}

-(void) viewDidAppear:(BOOL)animated {
    [self.segmentedControl.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addLogButton:(UIBarButtonItem *)sender {
    self.segueId = (self.segmentedControl.selectedSegmentIndex == 0) ? @"addDiabetesLogSegue" : @"addHypertensionLogSegue";
    [self performSegueWithIdentifier:self.segueId sender:sender];
}

- (IBAction)segmentSwitch:(SDSegmentedControl *)sender {
    self.segmentIndex = sender.selectedSegmentIndex;
    if (self.segmentIndex == 0) {
        self.logTable.logs = [self.dLog retrieveDiabetesLogs];
        if ([self.logTable.logs count] > 0) {
            self.logTable.logGroups = [self.dLog returnGroupingsWithLogs:self.logTable.logs];
        } else {
            [self.logTable.logGroups removeAllObjects];
        }
        self.logTable.type = 0;
    } else {
        self.logTable.logs = [self.hLog retrieveHypertensionLogs];
        if ([self.logTable.logs count] > 0) {
            self.logTable.logGroups = [self.hLog returnGroupingsWithLogs:self.logTable.logs];
        } else {
            [self.logTable.logGroups removeAllObjects];
        }
        self.logTable.type = 1;
        
    }
    [self.logTable.tableView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"logTableViewEmbedSegue"]) {
        self.logTable = segue.destinationViewController;
    }
}
@end
