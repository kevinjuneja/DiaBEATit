//
//  LogTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "LogTableViewController.h"
#import "DiabetesLogCell.h"
#import "HypertensionLogCell.h"
#import "DiabetesLog.h"
#import "HypertensionLog.h"
#import "DiabetesLogTableViewController.h"
#import "HypertensionLogTableViewController.h"
#import "Profile.h"

@interface LogTableViewController ()
@property (nonatomic) int logId;
@property (nonatomic, strong) Profile *profile;
@end

@implementation LogTableViewController

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
    NSLog(@"%@",[[self.logGroups objectAtIndex:0] objectAtIndex:0]);
    [self.tableView reloadData];
    self.profile = [[Profile alloc] init];
    self.profile = [[self.profile retrieveProfiles] objectAtIndex:0];

    
    self.tableView.contentOffset = CGPointMake(0.0f, 50.0f);
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -30, 200, 30)];
    NSString *myNewLineStr = @"\n";
    NSString *labelText = [NSString stringWithFormat:@"Glucose: %@ +/- 10 | Systolic: %@ +/- 10 | Diastolic: %@ +/- 5",[self.profile targetGlucose], [self.profile targetSystolicBP], [self.profile targetDiastolicBP]];
    labelText = [labelText stringByReplacingOccurrencesOfString:@"\\n" withString:myNewLineStr];

    testLabel.text = labelText;
    self.tableView.tableHeaderView = testLabel;
    testLabel.numberOfLines = 1;
    testLabel.minimumFontSize = 8.;
    testLabel.adjustsFontSizeToFitWidth = YES;
    testLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void) viewDidAppear:(BOOL)animated {
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"diabetesLogSegue"]){
        DiabetesLogTableViewController *dtvc = [segue destinationViewController];
        dtvc.logId = self.logId;
    } else {
        HypertensionLogTableViewController *htvc = [segue destinationViewController];
        htvc.logId = self.logId;
    }
}

#pragma mark - Table view data source

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        DiabetesLogCell *cell = (DiabetesLogCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.logId = cell.logId;
        
        [self performSegueWithIdentifier:@"diabetesLogSegue" sender:cell];
    } else {
        HypertensionLogCell *cell = (HypertensionLogCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.logId = cell.logId;
        
        [self performSegueWithIdentifier:@"hypertensionLogSegue" sender:cell];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.logGroups count] == 0) {
        return 0;
    } else {
        // Return the number of sections.
        return [self.logGroups count];
    }
}

-(NSString *) tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)s
{
    if ([self.logGroups count] == 0) {
        return @"";
    } else {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyyMMdd"];
        NSDate* d = [df dateFromString:[[self.logGroups objectAtIndex:s] objectAtIndex:0]];
        
        [df setDateFormat:@"MMMM dd, yyyy"];
        NSString *title = [df stringFromDate:d];
        return title;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if ([self.logGroups count] == 0) {
        return 1;
    } else {
        return [self.logGroups[section] count] - 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSUInteger row = indexPath.row;
    
    NSArray *logData = [self.logGroups objectAtIndex:indexPath.section];
    
    
    if (self.type == 0) {
        static NSString *CellIdentifier = @"diabetesLogCell";
        DiabetesLogCell *tempCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempCell == nil) {
            cell = [[DiabetesLogCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        DiabetesLog *dlToAdd = [logData objectAtIndex:row+1];
        tempCell.glucoseLabel.text = dlToAdd.glucose;
        if ([tempCell.a1cLabel.text isEqualToString:@""]) {
            [tempCell.a1cNameLabel setHidden:YES];
        } else {
            tempCell.a1cLabel.text = dlToAdd.a1c;
        }
        if ([dlToAdd.timeOfDay isEqualToString:@"0"]) {
            UIImage *image = [UIImage imageNamed: @"171-morning.png"];
            [tempCell.timeOfDayImage setImage:image];
        } else if ([dlToAdd.timeOfDay isEqualToString:@"1"]) {
            UIImage *image = [UIImage imageNamed: @"171-sun.png"];
            [tempCell.timeOfDayImage setImage:image];
        } else {
            tempCell.timeOfDayImage.frame = CGRectMake(20.0f, 15.0f, 30.0f, 30.0f);
            UIImage *image = [UIImage imageNamed: @"126-moon.png"];
            [tempCell.timeOfDayImage setImage:image];
        }
        if ([dlToAdd.glucose intValue] > [self.profile.targetGlucose intValue] + 10 || [dlToAdd.glucose intValue] < [self.profile.targetGlucose intValue] - 10 ||[dlToAdd.glucose intValue] < 70 || [dlToAdd.glucose intValue] > 170 ||
            [dlToAdd.a1c intValue] > 8) {
            tempCell.analysis.backgroundColor = [UIColor redColor];
        } else {
            tempCell.analysis.backgroundColor = [UIColor greenColor];
        }
        tempCell.logId = dlToAdd.idCode;
        cell = tempCell;
        
    } else {
        static NSString *CellIdentifier = @"hypertensionLogCell";
        HypertensionLogCell *tempCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempCell == nil) {
            cell = [[HypertensionLogCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        HypertensionLog *hlToAdd = [logData objectAtIndex:row+1];
        tempCell.systolicLabel.text = hlToAdd.systolic;
        tempCell.diastolicLabel.text = hlToAdd.diastolic;
        
        if ([hlToAdd.timeOfDay isEqualToString:@"0"]) {
            UIImage *image = [UIImage imageNamed: @"171-morning.png"];
            [tempCell.timeOfDayImage setImage:image];
        } else if ([hlToAdd.timeOfDay isEqualToString:@"1"]) {
            UIImage *image = [UIImage imageNamed: @"171-sun.png"];
            [tempCell.timeOfDayImage setImage:image];
        } else {
             tempCell.timeOfDayImage.frame = CGRectMake(20.0f, 15.0f, 30.0f, 30.0f);
            UIImage *image = [UIImage imageNamed: @"126-moon.png"];
            [tempCell.timeOfDayImage setImage:image];
        }
        
        if ([hlToAdd.systolic intValue] > [self.profile.targetSystolicBP intValue] + 10 || [hlToAdd.systolic intValue] < [self.profile.targetSystolicBP intValue] - 10 ||[hlToAdd.diastolic intValue] < [self.profile.targetDiastolicBP intValue] - 5 ||[hlToAdd.diastolic intValue] > [self.profile.targetDiastolicBP intValue] + 5 ||
            [hlToAdd.systolic intValue] < 100 || [hlToAdd.systolic intValue] > 170 ||
            [hlToAdd.diastolic intValue] > 90 || [hlToAdd.diastolic intValue] < 60) {
            tempCell.analysis.backgroundColor = [UIColor redColor];
        } else {
            tempCell.analysis.backgroundColor = [UIColor greenColor];
        }
        tempCell.logId = hlToAdd.idCode;
        cell = tempCell;
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (self.type == 0) {
            DiabetesLog *dl = [[self.logGroups objectAtIndex:indexPath.section]objectAtIndex:indexPath.row+1];
            [dl removeDiabetesLogWithId:dl.idCode];
        } else {
            HypertensionLog *hl = [[self.logGroups objectAtIndex:indexPath.section]objectAtIndex:indexPath.row+1];
            [hl removeHypertensionLogWithId:hl.idCode];
        }
        
        [[self.logGroups objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row+1];
        
        if ([[self.logGroups objectAtIndex:indexPath.section] count] == 1) {
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            [self.logGroups removeObjectAtIndex:indexPath.section];
//            [tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [self.tableView reloadData];
        [self.tableView endUpdates];
    }
}

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
