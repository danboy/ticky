//
//  tickyAppDelegate.m
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright petenawara.com 2008. All rights reserved.
//

#import "tickyAppDelegate.h"
#import "ProjectViewController.h"
#import "Project.h"

@implementation tickyAppDelegate

@synthesize window, projects;


- (void)applicationDidFinishLaunching:(UIApplication *)application {   
	[self createEditableCopyOfDatabaseIfNeeded];
    // Call internal method to initialize database connection
	[self initializeDatabase];
    ProjectViewController *projectViewController = [[ProjectViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:projectViewController];
    // Override point for customization after app launch    
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"ticky.db"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ticky.db"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
// Open the database connection and retrieve minimal information for all objects.
- (void)initializeDatabase {
    NSMutableArray *projectsArray = [[NSMutableArray alloc] init];
    self.projects = projectsArray;
    [projectsArray release];
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ticky.db"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        // Get the primary key for all books.
        const char *sql = "SELECT id FROM projects";
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                int primaryKey = sqlite3_column_int(statement, 0);
                // We avoid the alloc-init-autorelease pattern here because we are in a tight loop and
                // autorelease is slightly more expensive than release. This design choice has nothing to do with
                // actual memory management - at the end of this block of code, all the book objects allocated
                // here will be in memory regardless of whether we use autorelease or release, because they are
                // retained by the books array.
                Project *project = [[Project alloc] initWithPrimaryKey:primaryKey database:database];
				NSLog(project.name);
                [projects addObject:project];
                [project release]; 
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
}

// Remove a specific book from the array of books and also from the database.
- (void)removeProject:(Project *)project {
    // Delete from the database first. The book knows how to do this (see Book.m)
    [project deleteFromDatabase];
    [projects removeObject:project];
}

// Insert a new project into the database and add it to the array of projects.
- (void)addProject:(Project    *)project {
    // Create a new record in the database and get its automatically generated primary key.
    NSLog(project.name);
	[project insertIntoDatabase:database];
    [projects addObject:project];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
