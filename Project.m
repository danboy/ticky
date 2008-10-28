//
//  Project.m
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import "Project.h"

static sqlite3_stmt *init_statement = nil;
static sqlite3_stmt *hydrate_statement = nil;
static sqlite3_stmt *delete_statement = nil;
static sqlite3_stmt *insert_statement = nil;

@implementation Project
@synthesize name, primaryKey;


+ (void)finalizeStatements {
	
    if (init_statement) sqlite3_finalize(init_statement);
	
    if (hydrate_statement) sqlite3_finalize(hydrate_statement);
	
	if (delete_statement) sqlite3_finalize(delete_statement);
	
	if (insert_statement) sqlite3_finalize(insert_statement);
	
}


- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
	
    if (self = [super init]) {
		
        primaryKey = pk;
		
        database = db;
		
		
        if (init_statement == nil) {
			
            const char *sql = "SELECT name FROM projects WHERE id=?";
			
            if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
				
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
				
            }
			
        }
		
        sqlite3_bind_int(init_statement, 1, primaryKey);
		
        if (sqlite3_step(init_statement) == SQLITE_ROW) {
			
            self.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
			
        } else {
			
            self.name = @"No name";
			
        }
		
        // Reset the statement for future reuse.
		
        sqlite3_reset(init_statement);
		
        dirty = NO;
		
    }
	
    return self;
	
}


- (void)hydrate {
	
    if (hydrated) return;
	
    if (hydrate_statement == nil) {
		
        const char *sql = "SELECT name FROM projects WHERE id=?";
		
        if (sqlite3_prepare_v2(database, sql, -1, &hydrate_statement, NULL) != SQLITE_OK) {
			
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			
        }
		
    }
	
    sqlite3_bind_int(hydrate_statement, 1, primaryKey);
	
    int success =sqlite3_step(hydrate_statement);
	
    if (success == SQLITE_ROW) {
		
        char *str = (char *)sqlite3_column_text(hydrate_statement, 0);
		
        self.name = (str) ? [NSString stringWithUTF8String:str] : @"";
		
    } else {
		
        self.name = @"Unknown";
		
    }
	
    sqlite3_reset(hydrate_statement);
	
    hydrated = YES;
	
}


- (void)insertIntoDatabase:(sqlite3 *)db {
	
    database = db;
	
    // This query may be performed many times during the run of the application. As an optimization, a static
	
    // variable is used to store the SQLite compiled byte-code for the query, which is generated one time - the first
	
    // time the method is executed by any Book object.
	
    if (insert_statement == nil) {
		
        static char *sql = "INSERT INTO projects (name) VALUES(?)";
		
        if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
			
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			
        }
		
    }
	
    sqlite3_bind_text(insert_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
	
    int success = sqlite3_step(insert_statement);
	
    // Because we want to reuse the statement, we "reset" it instead of "finalizing" it.
	
    sqlite3_reset(insert_statement);
	
    if (success == SQLITE_ERROR) {
		
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		
    } else {
		
        // SQLite provides a method which retrieves the value of the most recently auto-generated primary key sequence
		
        // in the database. To access this functionality, the table should have a column declared of type 
		
        // "INTEGER PRIMARY KEY"
		
        primaryKey = sqlite3_last_insert_rowid(database);
		
    }
	
    // All data for the book is already in memory, but has not be written to the database
	
    // Mark as hydrated to prevent empty/default values from overwriting what is in memory
	
    hydrated = YES;
	
}



- (void)deleteFromDatabase {
	
    // Compile the delete statement if needed.
	
    if (delete_statement == nil) {
		
        const char *sql = "DELETE FROM projects WHERE id=?";
		
        if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
			
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			
        }
		
    }
	
    // Bind the primary key variable.
	
    sqlite3_bind_int(delete_statement, 1, primaryKey);
	
    // Execute the query.
	
    int success = sqlite3_step(delete_statement);
	
    // Reset the statement for future use.
	
    sqlite3_reset(delete_statement);
	
    // Handle errors.
	
    if (success != SQLITE_DONE) {
		
        NSAssert1(0, @"Error: failed to delete from database with message '%s'.", sqlite3_errmsg(database));
		
    }
	
}

@end
