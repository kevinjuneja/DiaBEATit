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

-(int) editHypertensionLogWithId:(int)idCode systolicBP:(NSString *)systolic diastolicBP:(NSString *)diastolic heartRate:(NSString *)heartRate timeOfDay:(NSString *)timeOfDay timestamp:(NSString *)timestamp comments:(NSString *)comments
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
                               @"UPDATE HYPERTENSIONLOGS SET systolic = '\"%@\"', diastolic = '\"%@\"', heartrate = '\"%@\"', timeofday = '\"%@\"',  timestamp = '\"%@\"',  comments = '\"%@\"' WHERE id = '\"%i\"'",
                               systolic, diastolic, heartRate, timeOfDay, timestamp, comments, idCode];
        
        
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

-(int) removeHypertensionLogWithId:(int)idCode
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
                               @"DELETE FROM HYPERTENSIONLOGS WHERE id = '\"%i\"'", idCode];
        
        
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

-(NSArray *) retrieveHypertensionLogs {
    NSMutableArray *hypertensionlogs = [[NSMutableArray alloc] init];
    
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
                              @"SELECT id, systolic, diastolic, heartrate, timeofday, timestamp, comments FROM hypertensionlogs"];
        
        const char *query_stmt = [querySQL UTF8String];
        int check = sqlite3_prepare_v2(_diaBEATitDB, query_stmt, -1, &statement, NULL);
        //NSLog(@"%i", check);
        if (check == SQLITE_OK)
        {
            //NSLog(@"Entered 2nd if");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"Entered while");
                HypertensionLog *h = [[HypertensionLog alloc] init];
                
                int idField = sqlite3_column_int(statement, 0);
                
                h.idCode = idField;
                NSLog(@"ID: %i", h.idCode);
                
                NSString *systolicField = [[NSString alloc]
                                          initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                h.systolic = systolicField;
                NSLog(@"Systolic: %@", h.systolic);
                
                NSString *diastolicField = [[NSString alloc]
                                          initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                h.diastolic = diastolicField;
                NSLog(@"Diastolic: %@", h.diastolic);
                
                NSString *heartrateField = [[NSString alloc]
                                      initWithUTF8String:(const char *)
                                      sqlite3_column_text(statement, 3)];
                
                h.heartRate = heartrateField;
                NSLog(@"Heartrate: %@", h.heartRate);
                
                NSString *timeOfDayField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 4)];
                
                h.timeOfDay = timeOfDayField;
                NSLog(@"Time of Day: %@", h.timeOfDay);
                
                NSString *timestampField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 5)];
                
                h.timestamp = timestampField;
                NSLog(@"Timestamp: %@", h.timestamp);
                
                NSString *commentsField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 6)];
                
                h.comments = commentsField;
                NSLog(@"Comments: %@", h.comments);
                
                [hypertensionlogs addObject:h];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    //    NSMutableArray *temp = [[NSMutableArray alloc] init];
    //    int tempPtr = 0;
    //    for (int i = [medications count]; i >= 0; i--, tempPtr++) {
    //        [temp addObject:[medications objectAtIndex:i]];
    //    }
    
    return hypertensionlogs;
}

-(NSArray *) retrieveHypertensionLogsWithConstraints:(NSString *)constraints
{
    NSMutableArray *hypertensionlogs = [[NSMutableArray alloc] init];
    
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
        NSString *querySQL = [[NSString stringWithFormat:
                              @"SELECT id, systolic, diastolic, heartrate, timeofday, timestamp, comments FROM hypertensionlogs "] stringByAppendingString:constraints];
        
        const char *query_stmt = [querySQL UTF8String];
        int check = sqlite3_prepare_v2(_diaBEATitDB, query_stmt, -1, &statement, NULL);
        //NSLog(@"%i", check);
        if (check == SQLITE_OK)
        {
            //NSLog(@"Entered 2nd if");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"Entered while");
                HypertensionLog *h = [[HypertensionLog alloc] init];
                
                int idField = sqlite3_column_int(statement, 0);
                
                h.idCode = idField;
                NSLog(@"ID: %i", h.idCode);
                
                NSString *systolicField = [[NSString alloc]
                                           initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                h.systolic = systolicField;
                NSLog(@"Systolic: %@", h.systolic);
                
                NSString *diastolicField = [[NSString alloc]
                                            initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                h.diastolic = diastolicField;
                NSLog(@"Diastolic: %@", h.diastolic);
                
                NSString *heartrateField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 3)];
                
                h.heartRate = heartrateField;
                NSLog(@"Heartrate: %@", h.heartRate);
                
                NSString *timeOfDayField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 4)];
                
                h.timeOfDay = timeOfDayField;
                NSLog(@"Time of Day: %@", h.timeOfDay);
                
                NSString *timestampField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 5)];
                
                h.timestamp = timestampField;
                NSLog(@"Timestamp: %@", h.timestamp);
                
                NSString *commentsField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 6)];
                
                h.comments = commentsField;
                NSLog(@"Comments: %@", h.comments);
                
                [hypertensionlogs addObject:h];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    //    NSMutableArray *temp = [[NSMutableArray alloc] init];
    //    int tempPtr = 0;
    //    for (int i = [medications count]; i >= 0; i--, tempPtr++) {
    //        [temp addObject:[medications objectAtIndex:i]];
    //    }
    
    return hypertensionlogs;
}

@end
