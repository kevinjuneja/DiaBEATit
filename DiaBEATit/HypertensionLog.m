//
//  HypertensionLog.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "HypertensionLog.h"

@implementation HypertensionLog

-(int) saveHypertensionLogWithSystolicBP:(NSString *)systolic diastolicBP:(NSString *)diastolic heartRate:(NSString *)heartRate timeOfDay:(NSString *)timeOfDay timestamp:(NSString *)timestamp comments:(NSString *)comments
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
                               @"INSERT INTO HYPERTENSIONLOGS (systolic, diastolic, heartrate, timeofday, timestamp, comments) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               systolic, diastolic, heartRate, timeOfDay, timestamp, comments];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_diaBEATitDB, insert_stmt,
                           -1, &statement, NULL);
        sqlCheck = sqlite3_step(statement);
        if (sqlCheck == SQLITE_DONE)
        {
            NSLog(@"SUCCEEDED");
        } else {
            NSLog(@"FAILED");
            //_status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_diaBEATitDB);
    }
    
    
    return sqlCheck;
}

@end
