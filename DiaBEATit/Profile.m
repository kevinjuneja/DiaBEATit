//
//  Profile.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "Profile.h"

@implementation Profile

-(int) saveProfileLogWithName:(NSString *)name age:(NSString *)age gender:(NSString *)gender height:(NSString *)height weight:(NSString *)weight insulinDependency:(NSString *)insulinDepdency targetGlucose:(NSString *)targetGlucose targetSystolicBP:(NSString *)targetSystolicBP targetDiastolicBP:(NSString *)targetDiastolicBP
{
    sqlite3_stmt *statement;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath= [pathToDatabase UTF8String];
    int sqlCheck = 1;
    NSLog(@"here");

    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO PROFILES (name, age, gender, height, weight, insulindependency, targetglucose, tartgetsystolicbp, targetdiastolicbp) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               name, age, gender, height, weight, insulinDepdency, targetGlucose, targetSystolicBP, targetDiastolicBP];
        NSLog(@"here");
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_diaBEATitDB, insert_stmt,
                           -1, &statement, NULL);
        sqlCheck = sqlite3_step(statement);
        if (sqlCheck == SQLITE_DONE)
        {
            NSLog(@"SUCCEEDED");
        } else {
            NSLog(@"FAILED %i", sqlCheck);
            //_status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_diaBEATitDB);
    }
    
    
    return sqlCheck;
}

-(int) editProfileLogWithId:(int)idCode name:(NSString *)name age:(NSString *)age gender:(NSString *)gender height:(NSString *)height weight:(NSString *)weight insulinDependency:(NSString *)insulinDepdency targetGlucose:(NSString *)targetGlucose targetSystolicBP:(NSString *)targetSystolicBP targetDiastolicBP:(NSString *)targetDiastolicBP
{
    sqlite3_stmt *statement;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath= [pathToDatabase UTF8String];
    int sqlCheck = 1;
    
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE PROFILES SET name = '%@', age = '%@', gender = '%@', height = '%@', weight = '%@', insulindependency = '%@', targetglucose = '%@', targetsystolicbp = '%@', targetdiastolicbp = '%@' WHERE id = %i",
                               name, age, gender, height, weight, insulinDepdency, targetGlucose, targetSystolicBP, targetDiastolicBP, idCode];
        
        
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

-(NSArray *) retrieveProfiles
{
    NSMutableArray *profiles = [[NSMutableArray alloc] init];
    
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
                              @"SELECT name, age, gender, height, weight, insulindependency, targetglucose, targetsystolicbp, targetdiastolicbp FROM profiles"];
        
        const char *query_stmt = [querySQL UTF8String];
        int check = sqlite3_prepare_v2(_diaBEATitDB, query_stmt, -1, &statement, NULL);
        //NSLog(@"%i", check);
        if (check == SQLITE_OK)
        {
            //NSLog(@"Entered 2nd if");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"Entered while");
                Profile *p = [[Profile alloc] init];
                
                int idField = sqlite3_column_int(statement, 0);
                p.idCode = idField;
                NSLog(@"ID: %i", p.idCode);
                
                NSString *nameField = [[NSString alloc]
                                       initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                p.name = nameField;
                NSLog(@"Name: %@", p.name);
                
                NSString *ageField = [[NSString alloc]
                                         initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                p.age = ageField;
                NSLog(@"Age: %@", p.age);
                
                NSString *heightField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 3)];
                
                p.height = heightField;
                NSLog(@"Height: %@", p.height);
                
                NSString *weightField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 4)];
                
                p.weight = weightField;
                NSLog(@"Weight: %@", p.weight);
                
                NSString *insulinDependencyField = [[NSString alloc]
                                         initWithUTF8String:(const char *)
                                         sqlite3_column_text(statement, 4)];
                
                p.insulinDependency = insulinDependencyField;
                NSLog(@"Insulin Dependency: %@", p.insulinDependency);
                
                NSString *targetGlucoseField = [[NSString alloc]
                                         initWithUTF8String:(const char *)
                                         sqlite3_column_text(statement, 4)];
                
                p.targetGlucose = targetGlucoseField;
                NSLog(@"Target Glucose: %@", p.targetGlucose);
                
                NSString *targetSystolicField = [[NSString alloc]
                                         initWithUTF8String:(const char *)
                                         sqlite3_column_text(statement, 4)];
                
                p.targetSystolicBP = targetSystolicField;
                NSLog(@"Target Systolic: %@", p.targetSystolicBP);
                
                NSString *targetDiastolicField = [[NSString alloc]
                                         initWithUTF8String:(const char *)
                                         sqlite3_column_text(statement, 4)];
                
                p.targetDiastolicBP = targetDiastolicField;
                NSLog(@"Target Diastolic: %@", p.targetDiastolicBP);
                
                [profiles addObject:p];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    return profiles;
}

@end
