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

@interface AddDiabetesLogTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealTimingLabel;

@property (weak, nonatomic) IBOutlet UITextField *glucoseField;
@property (weak, nonatomic) IBOutlet UITextField *insulinField;
@property (weak, nonatomic) IBOutlet UITextField *a1cField;

@property (weak, nonatomic) IBOutlet UITextView *commentsText;

@property (strong, nonatomic) DiabetesLog *log;

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
//    self.glucoseCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.insulinCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.a1cCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.log = [[DiabetesLog alloc] init];
    self.timeOfDay = -1;
    self.mealTiming = -1;
}

-(void) viewWillAppear:(BOOL)animated {
    switch (self.timeOfDay) {
        case 0:
            self.timeOfDayLabel.text = @"Morning";
            self.log.timeOfDay = @"Morning";
            break;
            
        case 1:
            self.timeOfDayLabel.text = @"Afternoon";
            self.log.timeOfDay = @"Afternoon";
            break;
            
        case 2:
            self.timeOfDayLabel.text = @"Night";
            self.log.timeOfDay = @"Night";
            break;
            
        default:
            self.timeOfDayLabel.text = @" ";
            break;
    }
    
    switch (self.mealTiming) {
        case 0:
            self.mealTimingLabel.text = @"Before Meal";
            self.log.mealTiming = @"Before Meal";
            break;
            
        case 1:
            self.mealTimingLabel.text = @"After Meal";
            self.log.mealTiming = @"After Meal";
            break;
            
        case 2:
            self.mealTimingLabel.text = @"No Meal";
            self.log.mealTiming = @"No Meal";
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
    int saveResponse = [self.log saveDiabetesLogWithDiabetesObject:self.log];
    
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

// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if ( textField == self.glucoseField ) {
		self.log.glucose = textField.text ;
	} else if ( textField == self.insulinField ) {
		self.log.insulin = textField.text ;
	} else if ( textField == self.a1cField ) {
		self.log.a1c = textField.text ;
	}
}

@end
