//
//  DBManager.m
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/11/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if (self) {
        // Set the documents directory path to the documentDirectory property
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentDirectory = [paths objectAtIndex:0];
        
        // Keep the database filename
        self.databaseFilename = dbFilename;
        
        // Copy the database file into the documents directory if necessary
        [self copyDatabaseIntoDocumentDirectory];
    }
    return self;
}

-(void)copyDatabaseIntoDocumentDirectory{
    // Check if the database file exists in the documents directory
    NSString *destinationPath = [self.documentDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![NSFileManager.defaultManager fileExistsAtPath:destinationPath]) {
        NSString* sourcePath = [NSBundle.mainBundle.resourcePath stringByAppendingPathComponent:self.databaseFilename];
        NSError* error;
        [NSFileManager.defaultManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }
}

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    // Create a sqlite object
    sqlite3 *sqlite3Database;
    
    // Set the database file path
    NSString *databasePath = [self.documentDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    // Init the results array
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    // Init the column names array
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    // Open the database
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if (openDatabaseResult == SQLITE_OK){
        sqlite3_stmt* compiledStatement;
    
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        
        // Check if the query is non-executable
        if (prepareStatementResult == SQLITE_OK) {
            if (!queryExecutable) {
                // Declare an array to keep the data for each fetched row
                NSMutableArray* arrDataRow;
                
                // Loop through the results and add them to the results array row by row
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Initialize the mutable array that will contain the data of a fetched row
                    arrDataRow = [[NSMutableArray alloc] init];
                    
                    // Get the total number of columns
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
                    // Go through all columns and fetch each column data
                    for (int i=0; i<totalColumns; i++) {
                        // Convert column data to text (characters)
                        char* dbDataAsChars = (char*)sqlite3_column_text(compiledStatement, i);
                        
                        // If there are contents in the current column (field) then add them to the current row array
                        if (dbDataAsChars != NULL) {
                            // Convert the characters to string
                            [arrDataRow addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                        
                        // Keep the current column name
                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAsChars = (char*)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                    
                    // Store each fetched data row in the results array, but first check if there is actually data
                    if (arrDataRow.count > 0) {
                        [self.arrResults addObject:arrDataRow];
                    }
                }
            } else{
                // This is the case of an executable query (insert, update, ...)
                
                // Execute the query
                BOOL executeQueryResults = sqlite3_step(compiledStatement);
                
                if (executeQueryResults == SQLITE_DONE) {
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                } else{
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        } else{
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(sqlite3Database);
}

- (NSArray *)loadDataFromDB:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    
    return self.arrResults;
}

- (void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

@end
