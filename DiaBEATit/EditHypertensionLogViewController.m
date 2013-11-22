//
//  EditHypertensionLogViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "EditHypertensionLogViewController.h"
#import "SecondaryLogViewController.h"
#import "HypertensionLog.h"

@interface EditHypertensionLogViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;

@property (weak, nonatomic) IBOutlet UITextField *systolicField;
@property (weak, nonatomic) IBOutlet UITextField *diastolicField;
@property (weak, nonatomic) IBOutlet UITextField *heartRateField;
@property (weak, nonatomic) IBOutlet UITextView *commentsText;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) BOOL editingTime;
@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) UITextField *textFieldToResign;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic) BOOL shouldActNormal;
@end

@implementation EditHypertensionLogViewController

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
    if (self.systolicField.text.length > 0 && self.diastolicField.text.length > 0 && self.heartRateField.text.length > 0 && self.timeOfDay > -1) {
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
        self.systolicField.text = self.log.systolic;
        self.diastolicField.text = self.log.diastolic;
        self.heartRateField.text = self.log.heartRate;
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
    }
    
    
    if (self.systolicField.text.length > 0 && self.diastolicField.text.length > 0 && self.heartRateField.text.length > 0 && self.timeOfDay > -1) {
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

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    if (self.systolicField.text.length > 0 && self.diastolicField.text.length > 0 && self.heartRateField.text.length > 0 && self.timeOfDay > -1) {
        [self.saveButton setEnabled:YES];
        // database writing goes here
        HypertensionLog *hl = [[HypertensionLog alloc] init];
        /*int saveResponse = */[hl editHypertensionLogWithId:self.log.idCode systolicBP:self.systolicField.text diastolicBP:self.diastolicField.text heartRate:self.heartRateField.text timeOfDay:[NSString stringWithFormat:@"%d",self.timeOfDay] timestamp:self.timestamp comments:self.commentsText.text];
        
        // dismisses the modal after saving the info
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    SecondaryLogViewController *vc = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"editHypertensionTimeOfDaySegue"])
    {
        NSArray *array = @[@"Morning",@"Afternoon",@"Night"];
        [vc setLabelsFromStrings:array andTypeWithInt:0];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.systolicField.text.length > 0 && self.diastolicField.text.length > 0 && self.heartRateField.text.length > 0 && self.timeOfDay > -1) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.systolicField.text.length > 0 && self.diastolicField.text.length > 0 && self.heartRateField.text.length > 0 && self.timeOfDay > -1) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    [textField resignFirstResponder];
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) { // this is my picker cell
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
    if (indexPath.section == 1 && indexPath.row == 1) { // this is my date cell above the picker cell
        self.editingTime = !self.editingTime;
        [UIView animateWithDuration:.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
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
