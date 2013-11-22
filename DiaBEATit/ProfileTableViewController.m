//
//  ProfileTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/22/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "EditProfileViewController.h"
#import "Profile.h"

@interface ProfileTableViewController ()
@property (strong, nonatomic) Profile *profile;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *insulinDependentLabel;
@property (weak, nonatomic) IBOutlet UILabel *glucoseTargetLabel;
@property (weak, nonatomic) IBOutlet UILabel *systolicBPLabel;
@property (weak, nonatomic) IBOutlet UILabel *diastolicBPLabel;

@end

@implementation ProfileTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    self.profile = [[Profile alloc] init];
    self.profile = [[self.profile retrieveProfiles] objectAtIndex:0];
    self.nameLabel.text = self.profile.name;
    self.ageLabel.text = self.profile.age;
    self.genderLabel.text = self.profile.gender;
    self.heightLabel.text = self.profile.height;
    self.weightLabel.text = self.profile.weight;
    self.insulinDependentLabel.text = self.profile.insulinDependency;
    self.glucoseTargetLabel.text = self.profile.targetGlucose;
    self.systolicBPLabel.text = self.profile.targetSystolicBP;
    self.diastolicBPLabel.text = self.profile.targetDiastolicBP;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"editProfileSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        EditProfileViewController *controller = (EditProfileViewController *)navController.topViewController;
        controller.profile = self.profile;
    }
}


@end
