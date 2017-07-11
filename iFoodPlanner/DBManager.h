//
//  DBManager.h
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/11/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property(nonatomic,strong) NSString* documentDirectory;
@property(nonatomic,strong) NSString* databaseFilename;
@property(nonatomic,strong) NSMutableArray* arrColumnNames;
@property(nonatomic) int affectedRows;
@property(nonatomic) long long lastInsertedRowID;
@property(nonatomic,strong) NSMutableArray* arrResults;

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
-(void)copyDatabaseIntoDocumentDirectory;
-(void)runQuery:(const char*)query isQueryExecutable:(BOOL)queryExecutable;
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;
@end
