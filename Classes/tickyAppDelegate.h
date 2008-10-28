//
//  tickyAppDelegate.h
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright petenawara.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class ProjectViewController, Project;

@interface tickyAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	NSMutableArray *projects;
//	NSMutableArray *categories;
	sqlite3 *database;
	
	ProjectViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
// @property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *projects;


- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
- (void)addProject:(Project *)project;
- (void)removeProject:(Project *)project;


@end

