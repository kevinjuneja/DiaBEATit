//
//  Medication.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Medication : NSObject

@property (nonatomic) int idCode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dosage;
@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString *comments;
@property (nonatomic) sqlite3 *diaBEATitDB;


-(int) saveMedicationWithName:(NSString *)name dosage:(NSString *)dosage quantity:(NSString *)quantity comments:(NSString *)comments;

//Do not allow editing of idCode.
-(int) editMedicationWithId:(int)idCode name:(NSString *)name dosage:(NSString *)dosage quantity:(NSString *)quantity comments:(NSString *)comments;

-(int) removeMedicationWithId:(int)idCode;

-(NSMutableArray *) retrieveMedications;

-(Medication *) retrieveMedicationWithConstraints:(NSString*) name;

@end
