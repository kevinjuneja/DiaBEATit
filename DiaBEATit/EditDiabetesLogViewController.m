//
//  EditDiabetesLogViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "EditDiabetesLogViewController.h"
#import "SecondaryLogViewController.h"
#import "DiabetesLog.h"
#import "LogsHomeViewController.h"

@interface EditDiabetesLogViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealTimingLabel;

@property (weak, nonatomic) IBOutlet UITextField *glucoseField;
@property (weak, nonatomic) IBOutlet UITextField *insulinField;
@property (weak, nonatomic) IBOutlet UITextField *a1cField;

@property (weak, nonatomic) IBOutlet UITextView *commentsText;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) BOOL editingTime;
@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITextField *textFieldToResign;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic) BOOL shouldActNormal;
@end

@implementation EditDiabetesLogViewController

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
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    self.timestamp = [formatter stringFromDate:self.datePicker.date];
    
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    self.timestampLabel.text = [formatter stringFromDate:self.datePicker.date];
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(dismissKeyboard)];
    
}

-(void)dismissKeyboard {
    [self.textFieldToResign resignFirstResponder];
    [self.view removeGestureRecognizer:self.tap];
    if (self.glucoseField.text.length > 0 && self.insulinField.text.length > 0 && self.timeOfDay > -1 && self.mealTiming > -1) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldToResign = textField;
    [self.view addGestureRecognizer:self.tap];
}

-(void) viewWillAppear:(BOOL)animated {
    if (!self.shouldActNormal) {
        self.glucoseField.text = self.log.glucose;
        self.insulinField.text = self.log.insulin;
        if (self.log.a1c.length > 0) {
            self.a1cField.text = self.log.a1c;
        } else {
            self.a1cField.text = @"";
        }
        if ([self.log.timeOfDay isEqualToString:@"0"]) {
            self.timeOfDayLabel.text = @"Morning";
            self.timeOfDay = 0;
        } else if ([self.log.timeOfDay isEqualToString:@"1"]) {
            self.timeOfDayLabel.text = @"Afternoon";
            self.timeOfDay = 1;
        } else {
            self.timeOfDayLabel.text = @"Night";
            self.timeOfDay = 2;
        }
        if ([self.log.mealTiming isEqualToString:@"0"]) {
            self.mealTimingLabel.text = @"Before Meal";
            self.mealTiming = 0;
        } else if ([self.log.mealTiming isEqualToString:@"1"]) {
            self.mealTimingLabel.text = @"After Meal";
            self.mealTiming = 1;
        } else {
            self.mealTimingLabel.text = @"No Meal";
            self.mealTiming = 2;
        }
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyyMMdd"];
        NSDate* d = [df dateFromString:self.log.timestamp];
        
        [df setDateFormat:@"MMMM dd, yyyy"];
        NSString *dateString = [df stringFromDate:d];
        self.timestampLabel.text = dateString;
        self.timestamp = self.log.timestamp;
        self.commentsText.text = self.log.comments;
        
        self.shouldActNormal = YES;
    } else {
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
    
    
    if (self.glucoseField.text.length > 0 && self.insulinField.text.length > 0 && self.timeOfDay > -1 && self.mealTiming > -1) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
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
    if (self.glucoseField.text.length > 0 && self.insulinField.text.length > 0 && self.timeOfDay > -1 && self.mealTiming > -1) {
        [self.saveButton setEnabled:YES];
        // database writing goes here
        DiabetesLog *dl = [[DiabetesLog alloc] init];
        /*int saveResponse = */[dl editDiabetesLogWithId:self.log.idCode glucose:self.glucoseField.text insulin:self.insulinField.text a1c:self.a1cField.text timeOfDay:[NSString stringWithFormat:@"%d",self.timeOfDay] mealTiming:[NSString stringWithFormat:@"%d",self.mealTiming]timestamp:self.timestamp comments:self.commentsText.text];
        
        // dismisses the modal after saving the info
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    SecondaryLogViewController *vc = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"editTimeOfDaySegue"])
    {
        NSArray *array = @[@"Morning",@"Afternoon",@"Night"];
        [vc setLabelsFromStrings:array andTypeWithInt:0];
    } else {
        NSArray *array = @[@"Before Meal",@"After Meal",@"No Meal"];
        [vc setLabelsFromStrings:array andTypeWithInt:1];
    }
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.glucoseField.text.length > 0 && self.insulinField.text.length > 0 && self.timeOfDay > -1 && self.mealTiming > -1) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.glucoseField.text.length > 0 && self.insulinField.text.length > 0 && self.timeOfDay > -1 && self.mealTiming > -1) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    [textField resignFirstResponder];
    return YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 3) { // this is my picker cell
        if (self.editingTime) {
            return 219;
        } else {
            return 0;
        }
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        return 60;
    } else {
        return self.tableView.rowHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) { // this is my date cell above the picker cell
        self.editingTime = !self.editingTime;
        [UIView animateWithDuration:.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }];
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //
        //        [formatter setDateFormat:@"MMMM dd, yyyy"];
        //        self.timestampLabel.text = [formatter stringFromDate:self.datePicker.date];
    }
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    self.timestamp = [formatter stringFromDate:self.datePicker.date];
    
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    self.timestampLabel.text = [formatter stringFromDate:self.datePicker.date];
}




@end

