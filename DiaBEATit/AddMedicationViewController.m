//
//  AddMedicationViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/16/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddMedicationViewController.h"
#import "Medication.h"

@interface AddMedicationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dosageField;
@property (weak, nonatomic) IBOutlet UITextField *quantityField;
@property (weak, nonatomic) IBOutlet UITextField *commentsField;

@property (nonatomic) int saveResponse;

@end

@implementation AddMedicationViewController

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
    self.nameField.delegate = self; //self references the viewcontroller or view your textField is on
    self.dosageField.delegate = self;
    self.quantityField.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
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
    Medication *m = [[Medication alloc] init];
    self.saveResponse = [m saveMedicationWithName:self.nameField.text dosage:self.dosageField.text quantity:self.quantityField.text comments:self.commentsField.text];
    
    // dismisses the modal after saving the info
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
