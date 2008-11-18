//
//  AddProjectViewController.h
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@class Project, EditingViewController;

@interface AddProjectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
	Project *project;
	UITableView *tableView;
	NSIndexPath *selectedIndexPath;
	UITextField *textField;
}

@property (nonatomic, retain) Project *project;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) UITextField *textField;

- (IBAction)cancel:(id)sender;
- (void)saveProject;

@end
