//
//  AddDiabetesLogTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddDiabetesLogTableViewController.h"
#import "SecondaryLogViewController.h"

@interface AddDiabetesLogTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *glucoseCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *insulinCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *a1cCell;

@property (weak, nonatomic) IBOutlet UILabel *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealTimingLabel;

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
    self.timeOfDay = -1;
    self.mealTiming = -1;
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
            self.mealTimingLabel.text = @"Before meal";
            break;
            
        case 1:
            self.mealTimingLabel.text = @"After meal";
            break;
            
        case 2:
            self.mealTimingLabel.text = @"No meal";
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
        NSArray *array = @[@"Before meal",@"After meal",@"No meal"];
        [vc setLabelsFromStrings:array andTypeWithInt:1];
    }
}

@end
