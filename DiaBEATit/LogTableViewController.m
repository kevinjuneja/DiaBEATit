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

@interface LogTableViewController ()

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
    
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];
}

-(void) reloadLogs {
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    return 65.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSUInteger row = indexPath.row;
    
    NSArray *logData = [self.logGroups objectAtIndex:indexPath.section];
    
    BOOL ya = [[logData objectAtIndex:1] isKindOfClass:[HypertensionLog class]];
    NSLog(@"%s", ya ? "true" : "false");
    NSLog(@"%i",self.type);
    if (self.type == 0) {
        static NSString *CellIdentifier = @"diabetesLogCell";
        DiabetesLogCell *tempCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempCell == nil) {
            cell = [[DiabetesLogCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        DiabetesLog *dlToAdd = [logData objectAtIndex:row+1];
        tempCell.testLabel.text = dlToAdd.glucose;
        tempCell.analysis.backgroundColor = [UIColor redColor];
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
        tempCell.testLabel.text = hlToAdd.systolic;
        tempCell.analysis.backgroundColor = [UIColor greenColor];
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
