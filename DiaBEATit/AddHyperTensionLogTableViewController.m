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

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) BOOL editingTime;
@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) UITextField *textFieldToResign;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
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
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldToResign = textField;
    [self.view addGestureRecognizer:self.tap];
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
    /*int saveResponse = */[hl saveHypertensionLogWithSystolicBP:self.systolicField.text diastolicBP:self.diastolicField.text heartRate:self.heartRateField.text timeOfDay:self.timeOfDayLabel.text timestamp:self.timestamp comments:self.commentsText.text];

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
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"MMMM dd, yyyy"];
        self.timestampLabel.text = [formatter stringFromDate:self.datePicker.date];
    }
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    self.timestamp = [formatter stringFromDate:self.datePicker.date];
}
@end
