//
//  DiabetesLog.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DiabetesLog : NSObject

@property (nonatomic) int idCode;
@property (nonatomic, strong) NSString *glucose;
@property (nonatomic, strong) NSString *insulin;
@property (nonatomic, strong) NSString *a1c;
@property (nonatomic, strong) NSString *timeOfDay;
@property (nonatomic, strong) NSString *mealTiming;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *comments;

@property (nonatomic) sqlite3 *diaBEATitDB;

-(int) saveDiabetesLogWithGlucose:(NSString *)glucose insulin:(NSString *)insulin a1c:(NSString *)a1c timeOfDay:(NSString *)timeOfDay mealTiming:(NSString *)mealTiming timestamp:(NSString *)timestamp comments:(NSString *)comments;

-(int) saveDiabetesLogWithDiabetesObject:(DiabetesLog *)log;

-(int) editDiabetesLogWithId:(int)idCode glucose:(NSString *)glucose insulin:(NSString *)insulin a1c:(NSString *)a1c timeOfDay:(NSString *)timeOfDay mealTiming:(NSString *)mealTiming timestamp:(NSString *)timestamp comments:(NSString *)comments;

-(int) removeDiabetesLogWithId:(int)idCode;

-(NSArray *) retrieveDiabetesLogs;
-(NSArray *) retrieveDiabetesLogsWithConstraints:(NSString *)constraints;

-(NSArray *) returnGlucoseWithLogs:(NSArray *)logs;
-(NSArray *) returnDatesWithLogs:(NSArray *)logs;
-(NSArray *) returnGroupingsWithLogs:(NSArray *)logs;

@end
