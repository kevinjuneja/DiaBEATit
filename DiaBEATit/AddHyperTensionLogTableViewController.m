//
//  AddHyperTensionLogTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/20/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddHyperTensionLogTableViewController.h"
#import "SecondaryLogViewController.h"
#import "HypertensionLog.h"

@interface AddHyperTensionLogTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;

@property (weak, nonatomic) IBOutlet UITextField *systolicField;
@property (weak, nonatomic) IBOutlet UITextField *diastolicField;
@property (weak, nonatomic) IBOutlet UITextField *heartRateField;
@property (weak, nonatomic) IBOutlet UITextView *commentsText;
@end

@implementation AddHyperTensionLogTableViewController

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
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    self.timeOfDay = -1;
    
    self.systolicField.delegate = self; //self references the viewcontroller or view your textField is on
    self.diastolicField.delegate = self;
    self.heartRateField.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated {
    switch (self.timeOfDay) {
        case 0:
            self.timeOfDayLabel.text = @"Morning";
            break;
            
        case 1:
            self.timeOfDayLabel.text = @"Afternoon";
            break;
            
        case 2:
            self.timeOfDayLabel.text = @"Night";
            break;
            
        default:
            self.timeOfDayLabel.text = @" ";
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    // database writing goes here
    HypertensionLog *hl = [[HypertensionLog alloc] init];
    /*int saveResponse = */[hl saveHypertensionLogWithSystolicBP:self.systolicField.text diastolicBP:self.diastolicField.text heartRate:self.heartRateField.text timeOfDay:self.timeOfDayLabel.text timestamp:@"tempstring" comments:@"tempstring"];

    // dismisses the modal after saving the info
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    SecondaryLogViewController *vc = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"hypertensionTimeOfDaySegue"])
    {
        NSArray *array = @[@"Morning",@"Afternoon",@"Night"];
        [vc setLabelsFromStrings:array andTypeWithInt:0];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
