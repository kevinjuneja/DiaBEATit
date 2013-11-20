//
//  Exam.h
//  DiaBEATit
//
//  Created by App Jam on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Exam : NSObject{
    IBOutlet UILabel *lastCheckup;
    IBOutlet UILabel *examType;
}

@property (nonatomic) int idCode;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date;
@property (nonatomic) sqlite3 *diaBEATitDB;

-(IBAction)changeLastCheckupDate:(id)sender;

-(int) editExamWithID:(int)idCode date:(NSString *)date;

-(Exam *) retrieveExamsWithID:(int)idCode;

@end
