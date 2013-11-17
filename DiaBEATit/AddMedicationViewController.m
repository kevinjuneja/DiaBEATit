//
//  AddMedicationViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/16/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddMedicationViewController.h"

@interface AddMedicationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dosageField;
@property (weak, nonatomic) IBOutlet UITextField *quantityField;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
