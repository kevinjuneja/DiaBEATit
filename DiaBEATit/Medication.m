//
//  Medication.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "Medication.h"

@implementation Medication

-(int) saveMedicationWithName:(NSString *)name dosage:(NSString *)dosage quantity:(NSString *)quantity comments:(NSString *)comments
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
                               @"INSERT INTO MEDICINES (name, dosage, quantity, comments) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                               name, dosage, quantity, comments];
        
        
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

-(NSArray *) retrieveMedications {
    NSMutableArray *medications = [[NSMutableArray alloc] init];
    
    // sql query to get medications
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath = [pathToDatabase UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, dosage, quantity, comments FROM medications"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_diaBEATitDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Medication *m = [[Medication alloc] init];
                
                NSString *nameField = [[NSString alloc]
                                       initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                m.name = nameField;
                
                NSString *dosageField = [[NSString alloc]
                                          initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                m.dosage = dosageField;
                
                NSString *quantityField = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 2)];
                
                m.quantity = quantityField;
                
                NSString *commentsField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 3)];
                
                m.comments = commentsField;
                
                [medications addObject:m];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    return medications;
}

@end
