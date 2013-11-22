//
//  EditProfileViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "EditProfileViewController.h"
#import "SecondaryLogViewController.h"
#import "DiabetesLog.h"
#import "LogsHomeViewController.h"

@interface EditProfileViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *genderField;
@property (weak, nonatomic) IBOutlet UITextField *heightField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *insulinDependencyField;
@property (weak, nonatomic) IBOutlet UITextField *glucoseField;
@property (weak, nonatomic) IBOutlet UITextField *systolicBPField;
@property (weak, nonatomic) IBOutlet UITextField *diastolicBPField;


@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITextField *textFieldToResign;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation EditProfileViewController

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
    
    self.nameField.delegate = self; //self references the viewcontroller or view your textField is on
    self.ageField.delegate = self;
    self.genderField.delegate = self;
    self.heightField.delegate = self;
    self.weightField.delegate = self;
    self.insulinDependencyField.delegate = self;
    self.glucoseField.delegate = self;
    self.systolicBPField.delegate = self;
    self.diastolicBPField.delegate = self;
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(dismissKeyboard)];
    
}

-(void)dismissKeyboard {
    [self.textFieldToResign resignFirstResponder];
    [self.view removeGestureRecognizer:self.tap];
    if (self.nameField.text.length > 0 && self.ageField.text.length > 0 && self.genderField.text.length > 0 && self.heightField.text.length > 0 && self.weightField.text.length > 0 && self.insulinDependencyField.text.length > 0 && self.glucoseField.text.length > 0 && self.systolicBPField.text.length > 0 && self.diastolicBPField.text.length > 0) {
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
    self.nameField.text = self.profile.name;
    self.ageField.text = self.profile.age;
    self.genderField.text = self.profile.gender;
    self.heightField.text = self.profile.height;
    self.weightField.text = self.profile.weight;
    self.insulinDependencyField.text = self.profile.insulinDependency;
    self.glucoseField.text = self.profile.targetGlucose;
    self.systolicBPField.text = self.profile.targetSystolicBP;
    self.diastolicBPField.text = self.profile.targetDiastolicBP;
    
    
    if (self.nameField.text.length > 0 && self.ageField.text.length > 0 && self.genderField.text.length > 0 && self.heightField.text.length > 0 && self.weightField.text.length > 0 && self.insulinDependencyField.text.length > 0 && self.glucoseField.text.length > 0 && self.systolicBPField.text.length > 0 && self.diastolicBPField.text.length > 0) {
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
    if (self.nameField.text.length > 0 && self.ageField.text.length > 0 && self.genderField.text.length > 0 && self.heightField.text.length > 0 && self.weightField.text.length > 0 && self.insulinDependencyField.text.length > 0 && self.glucoseField.text.length > 0 && self.systolicBPField.text.length > 0 && self.diastolicBPField.text.length > 0) {
        [self.saveButton setEnabled:YES];
        // database writing goes here
        /*int saveResponse = */[self.profile editProfileLogWithId:self.profile.idCode name:self.nameField.text age:self.ageField.text gender:self.genderField.text height:self.heightField.text weight:self.weightField.text insulinDependency:self.insulinDependencyField.text targetGlucose:self.glucoseField.text targetSystolicBP:self.systolicBPField.text targetDiastolicBP:self.diastolicBPField.text];
        
        // dismisses the modal after saving the info
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
}


-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.nameField.text.length > 0 && self.ageField.text.length > 0 && self.genderField.text.length > 0 && self.heightField.text.length > 0 && self.weightField.text.length > 0 && self.insulinDependencyField.text.length > 0 && self.glucoseField.text.length > 0 && self.systolicBPField.text.length > 0 && self.diastolicBPField.text.length > 0) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.nameField.text.length > 0 && self.ageField.text.length > 0 && self.genderField.text.length > 0 && self.heightField.text.length > 0 && self.weightField.text.length > 0 && self.insulinDependencyField.text.length > 0 && self.glucoseField.text.length > 0 && self.systolicBPField.text.length > 0 && self.diastolicBPField.text.length > 0) {
        [self.saveButton setEnabled:YES];
    } else {
        [self.saveButton setEnabled:NO];
    }
    [textField resignFirstResponder];
    return YES;
}



@end

