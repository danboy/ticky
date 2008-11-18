//
//  AddActivityViewController.m
//  ticky
//
//  Created by Pete Nawara on 11/17/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import "AddActivityViewController.h"


@implementation AddActivityViewController
@synthesize activityView, textField;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    // 1 sections, one for each property
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    // Only one row for each section
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [activityView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
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




/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
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
