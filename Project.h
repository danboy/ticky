//
//  Project.h
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Project : NSObject {
	sqlite3 *database;
	
	BOOL dirty;
	BOOL hydrated;
	
	NSString *name;
	NSInteger primaryKey;
	
}

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (copy, nonatomic) NSString *name;

+ (void)finalizeStatements;
- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
- (void)hydrate;
- (void)insertIntoDatabase:(sqlite3 *)database;
- (void)deleteFromDatabase;

@end
