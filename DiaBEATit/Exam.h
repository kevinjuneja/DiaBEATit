//
//  Exam.h
//  DiaBEATit
//
//  Created by App Jam on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Exam : NSObject

@property (nonatomic) int idCode;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date;
@property (nonatomic) sqlite3 *diaBEATitDB;

-(int) editExamWithID:(int)idCode date:(NSString *)date;

-(NSArray *) retrieveExams;

@end
