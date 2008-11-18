//
//  AddProjectViewController.m
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import "AddProjectViewController.h"
#import "EditingViewController.h"
#import "Project.h"
#import "tickyAppDelegate.h"


@implementation AddProjectViewController

@synthesize tableView, selectedIndexPath, textField, project;

- (void)viewDidLoad {
    // Override the DetailViewController viewDidLoad with different navigation bar items and title
    self.title = @"New Project";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																						   target:self action:@selector(cancel:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																							target:self action:@selector(saveProject)] autorelease];
	self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.view addSubview: tableView];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)saveProject {
	self.project = [[Project alloc] init];
	self.project.name = textField.text;
	tickyAppDelegate *appdelegate = (tickyAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appdelegate addProject:self.project];
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    // 1 sections, one for each property
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    // Only one row for each section
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        // Create a new cell. CGRectZero allows the cell to determine the appropriate size.
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
    }
    if(indexPath.section == 0) {
			CGRect textFieldFrame = CGRectMake(0.0, 0.0, 280.0, 30.0);
			textField = [[UITextField alloc] initWithFrame:textFieldFrame];
			//[textField setBorderStyle:UITextBorderStyleRoundedRect];
			[textField setTextColor:[UIColor blackColor]];
			[textField setDelegate:self];
			[textField setPlaceholder:@"<project name>"];
			//[textField setBackgroundColor:[UIColor whiteColor]];
			textField.keyboardType = UIKeyboardTypeDefault;
			textField.font = [UIFont systemFontOfSize:22];
			UIView *textFieldView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 300.0, 50.0)];
			[textFieldView addSubview:textField];
			//cell.view = textFieldView;
			[cell.contentView addSubview:textFieldView];
			//cell.view = textField;
	}
    return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
        case 0: return @"Name";
    }
    return nil;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditingViewController *controller = [[EditingViewController alloc] init];
    
    controller.project = project;
    switch (indexPath.section) {
        case 0: {
            //controller.textValue = project.name;
            controller.editedFieldKey = @"name";
        } break;
	}
    self.selectedIndexPath = indexPath;
    [self.navigationController pushViewController:controller animated:YES];
}
 */



- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Only allow selection if editing.
    return (self.editing) ? indexPath : nil;
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditingViewController *controller = [MasterViewController editingViewController];
    
    controller.editedObject = project;
    switch (indexPath.section) {
        case 0: {
            controller.textValue = project.name;
            controller.editedFieldKey = @"name";
        } break;
          }
    self.selectedIndexPath = indexPath;
    [self.navigationController pushViewController:controller animated:YES];
}*/
/*
- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    // Show the disclosure indicator if editing.
    return (self.editing) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}
*/




/*
- (IBAction)save:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Add the book to the global array of books
    [appDelegate addBook:self.book];
    // Dismiss the modal view to return to the main list
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
*/ 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
