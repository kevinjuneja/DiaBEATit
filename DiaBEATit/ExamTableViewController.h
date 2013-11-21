//
//  ExamTableViewController.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ExamTableViewController : UITableViewController{
    IBOutlet UILabel *eyeExamDateLabel;
    IBOutlet UILabel *footExamDateLabel;
    IBOutlet UILabel *dentalExamDateLabel;
    IBOutlet UILabel *fastingSerumDateLabel;
    IBOutlet UILabel *urinaryRatioDateLabel;
    IBOutlet UILabel *fluVaccineDateLabel;
    
}

@property (nonatomic) int idCode;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date;
@property (nonatomic) sqlite3 *diaBEATitDB;

-(int) editExamWithID:(int)idCode date:(NSString *)date;

-(NSArray *) retrieveExams;

-(IBAction)changeLastEyeCheckupDate:(id)sender;
-(IBAction)changeLastFootCheckupDate:(id)sender;
-(IBAction)changeLastDentalCheckupDate:(id)sender;
-(IBAction)changeLastFastingSerumCheckupDate:(id)sender;
-(IBAction)changeLastUrinaryRatioCheckupDate:(id)sender;
-(IBAction)changeLastFluVaccineCheckupDate:(id)sender;


@end
