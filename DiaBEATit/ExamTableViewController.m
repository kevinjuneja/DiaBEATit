//
//  ExamTableViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "ExamTableViewController.h"

@interface ExamTableViewController ()

@end

@implementation ExamTableViewController

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
    
    NSArray *temp = [[NSMutableArray alloc] init];
    temp = [self retrieveExams];
    for (int i = 0; i < 6; i++) {
        if (![temp[i] isEqualToString:@"NULL"]) {
            if (i == 0) {
                eyeExamDateLabel.text = temp[0];
            }
            else if(i == 1){
                footExamDateLabel.text = temp[1];
            }
            else if(i == 2){
                dentalExamDateLabel.text = temp[2];
            }
            else if(i == 3){
                fastingSerumDateLabel.text = temp[3];
            }
            else if(i == 4){
                urinaryRatioDateLabel.text = temp[4];
            }
            else if(i == 5){
                fluVaccineDateLabel.text = temp[5];
            }
                
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int) editExamWithID:(int)idCode date:(NSString *)date
{
    sqlite3_stmt *statement;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath= [pathToDatabase UTF8String];
    int sqlCheck = 1;
    
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        NSLog(@"id:%i date:%@",idCode,date);
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE EXAMS SET date = '\%@\' WHERE id = %i", date, idCode];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_diaBEATitDB, insert_stmt,
                           -1, &statement, NULL);
        sqlCheck = sqlite3_step(statement);
        if (sqlCheck == SQLITE_DONE)
        {
            NSLog(@"SUCCEEDED");
        } else {
            NSLog(@"FAILED");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_diaBEATitDB);
    }
    return sqlCheck;
}

-(NSArray *) retrieveExams
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    // sql query to get medications
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath = [pathToDatabase UTF8String];
    sqlite3_stmt *statement;
    //NSLog(@"Entered function");
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        //NSLog(@"Entered 1st if");
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT id, date FROM exams"];
        
        const char *query_stmt = [querySQL UTF8String];
        int check = sqlite3_prepare_v2(_diaBEATitDB, query_stmt, -1, &statement, NULL);
        //NSLog(@"%i", check);
        if (check == SQLITE_OK)
        {
            //NSLog(@"Entered 2nd if");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSLog(@"Entered while");
                
                int idField = sqlite3_column_int(statement, 0);
                NSLog(@"%i", idField);
                
                NSString *dateField = [[NSString alloc]
                                       initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                [dates addObject:dateField];
                
                NSLog(@"Date: %@", dateField);
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    return dates;
    
}

-(IBAction)changeLastEyeCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];

    //[self editExamWithID:1 date:dateString];
    
    eyeExamDateLabel.text = dateString;
    
    [self editExamWithID:1 date:dateString];

}

-(IBAction)changeLastFootCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [self editExamWithID:2 date:dateString];
    
    footExamDateLabel.text = dateString;
}

-(IBAction)changeLastDentalCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [self editExamWithID:3 date:dateString];
    
    dentalExamDateLabel.text = dateString;
}

-(IBAction)changeLastFastingSerumCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [self editExamWithID:4 date:dateString];
    
    fastingSerumDateLabel.text = dateString;
}

-(IBAction)changeLastUrinaryRatioCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [self editExamWithID:5 date:dateString];
    
    urinaryRatioDateLabel.text = dateString;
}

-(IBAction)changeLastFluVaccineCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [self editExamWithID:6 date:dateString];
    
    fluVaccineDateLabel.text = dateString;
}

@end
