//
//  AddDiabetesLogViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "AddDiabetesLogViewController.h"
#import "FormTextFieldCell.h"
#import "FormPredefinedChoicesCell.h"

@interface AddDiabetesLogViewController ()
@property (nonatomic, strong) UITextField* glucoseField;
@property (nonatomic, strong) UITextField* insulinField;
@property (nonatomic, strong) UITextField* a1cField;
@property (nonatomic, strong) UITextField* commentsField;
@end

@implementation AddDiabetesLogViewController

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
    
    // dismisses the modal after saving the info
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    
    switch (indexPath.row) {
		case 0: {
            static NSString *cellIdentifier = @"textFieldCell";
            FormTextFieldCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (tempCell == nil) {
                cell = [[FormTextFieldCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:cellIdentifier];
            }
            tempCell.label.text = @"Glucose Level";
            cell = tempCell;
			break;
		}
		case 1: {
			static NSString *cellIdentifier = @"predefinedChoicesCell";
            FormPredefinedChoicesCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (tempCell == nil) {
                cell = [[FormPredefinedChoicesCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:cellIdentifier];
            }
            tempCell.label.text = @"Time of day";
            cell = tempCell;
			break;
		}
//		case 2: {
//			cell.textLabel.text = @"Password" ;
//			tf = passwordField_ = [self makeTextField:self.password placeholder:@"Required"];
//			[cell addSubview:passwordField_];
//			break ;
//		}
//		case 3: {
//			cell.textLabel.text = @"Description" ;
//			tf = descriptionField_ = [self makeTextField:self.description placeholder:@"My Gmail Account"];
//			[cell addSubview:descriptionField_];
//			break ;
//		}
    }
    // Make cell unselectable
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
