//
//  AddDiabetesLogTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddDiabetesLogTableViewController.h"
#import "SecondaryLogViewController.h"
#import "DiabetesLog.h"
#import "LogsHomeViewController.h"

@interface AddDiabetesLogTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealTimingLabel;

@property (weak, nonatomic) IBOutlet UITextField *glucoseField;
@property (weak, nonatomic) IBOutlet UITextField *insulinField;
@property (weak, nonatomic) IBOutlet UITextField *a1cField;

@property (weak, nonatomic) IBOutlet UITextView *commentsText;

@end

@implementation AddDiabetesLogTableViewController

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
	// Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

    self.timeOfDay = -1;
    self.mealTiming = -1;
    
    self.glucoseField.delegate = self; //self references the viewcontroller or view your textField is on
    self.insulinField.delegate = self;
    self.a1cField.delegate = self;
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
    
    switch (self.mealTiming) {
        case 0:
            self.mealTimingLabel.text = @"Before Meal";
            break;
            
        case 1:
            self.mealTimingLabel.text = @"After Meal";
            break;
            
        case 2:
            self.mealTimingLabel.text = @"No Meal";
            break;
            
        default:
            self.mealTimingLabel.text = @" ";
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    // database writing goes here
    DiabetesLog *dl = [[DiabetesLog alloc] init];
    /*int saveResponse = */[dl saveDiabetesLogWithGlucose:self.glucoseField.text insulin:self.insulinField.text a1c:self.a1cField.text timeOfDay:self.timeOfDayLabel.text mealTiming:self.mealTimingLabel.text timestamp:@"tempstring" comments:@"tempstring"];
    
    // dismisses the modal after saving the info
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    SecondaryLogViewController *vc = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"diabetesTimeOfDaySegue"])
    {
        NSArray *array = @[@"Morning",@"Afternoon",@"Night"];
        [vc setLabelsFromStrings:array andTypeWithInt:0];
    } else {
        NSArray *array = @[@"Before Meal",@"After Meal",@"No Meal"];
        [vc setLabelsFromStrings:array andTypeWithInt:1];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


@end
