//
//  AddMedicationTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/20/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddMedicationTableViewController.h"
#import "Medication.h"

@interface AddMedicationTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dosageField;
@property (weak, nonatomic) IBOutlet UITextField *quantityField;
@property (weak, nonatomic) IBOutlet UITextView *commentsText;

@property (nonatomic, strong) UITextField *textFieldToResign;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddMedicationTableViewController

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
    
    self.nameField.delegate = self; //self references the viewcontroller or view your textField is on
    self.dosageField.delegate = self;
    self.quantityField.delegate = self;
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(dismissKeyboard)];
    
}

-(void)dismissKeyboard {
    if (self.nameField.text.length > 0 && self.dosageField.text.length > 0 && self.quantityField.text.length > 0) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    [self.textFieldToResign resignFirstResponder];
    [self.view removeGestureRecognizer:self.tap];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldToResign = textField;
    [self.view addGestureRecognizer:self.tap];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.nameField.text.length > 0 && self.dosageField.text.length > 0 && self.quantityField.text.length > 0) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    return YES;
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
    if (self.nameField.text.length > 0 && self.dosageField.text.length > 0 && self.quantityField.text.length > 0) {
        [self.saveButton setEnabled:YES];
        // database writing goes here
        Medication *m = [[Medication alloc] init];
        /*int saveResponse = */[m saveMedicationWithName:self.nameField.text dosage:self.dosageField.text quantity:self.quantityField.text comments:self.commentsText.text];
        
        // dismisses the modal after saving the info
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.nameField.text.length > 0 && self.dosageField.text.length > 0 && self.quantityField.text.length > 0) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    [textField resignFirstResponder];
    
    return YES;
}

@end
