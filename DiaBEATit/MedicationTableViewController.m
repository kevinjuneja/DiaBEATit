//
//  MedicationTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/16/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "MedicationTableViewController.h"
#import "MedicationTableViewCell.h"
#import "Medication.h"

@interface MedicationTableViewController ()
@property (nonatomic, strong) NSArray *medications;
@end

@implementation MedicationTableViewController

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
    self.tableView.delegate = self;
    
    Medication *med = [[Medication alloc] init];
    self.medications = [med retrieveMedications];
}

-(void)viewWillAppear:(BOOL)animated {
    // need to reset medications array
    Medication *med = [[Medication alloc] init];
    self.medications = [med retrieveMedications];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.medications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSUInteger row = indexPath.row;
    
    static NSString *CellIdentifier = @"medicationCell";
    MedicationTableViewCell *tempCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tempCell == nil) {
        NSLog(@"not nil");
        cell = [[MedicationTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    Medication *toAdd = [self.medications objectAtIndex:row];
    tempCell.medicationNameLabel.text = toAdd.name;
    tempCell.medicationDosageLabel .text = [toAdd.dosage stringByAppendingString: @" mg"];
    tempCell.medicationQuantityLabel.text = [toAdd.quantity stringByAppendingString: @" count"];
    cell = tempCell;
    
    return cell;
    
//    tempCell.cappegoryTitle.text = [c title];
//    tempCell.followerCount.text = [NSString stringWithFormat:@"%i", [[c followers] count]];
//    tempCell.likeCount.text = @"0"; //need some way to get likes from Cappegory object
//    tempCell.appCount.text = [NSString stringWithFormat:@"%i", [[c cappegoryApps] count]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
