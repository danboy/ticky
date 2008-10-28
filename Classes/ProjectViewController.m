//
//  ProjectViewController.m
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import "ProjectViewController.h"
#import "tickyAppDelegate.h"
#import "Project.h"
#import "AddProjectViewController.h"
#import "ActivityViewController.h"


@implementation ProjectViewController
@synthesize addNavigationController;

- (void)viewDidLoad {
	
	self.title = @"Projects";
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(transitionToAddView:)];
	
	self.navigationItem.rightBarButtonItem = addButton;
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
}


- (void)transitionToAddView:(id)sender {
	
	AddProjectViewController *addProjectViewController=[[AddProjectViewController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addProjectViewController];
	self.addNavigationController=navController;
	[navController release];
	[self.navigationController presentModalViewController:addNavigationController animated:YES];
	[addProjectViewController setEditing:YES animated:NO];
		
}


- (void)viewWillAppear:(BOOL)animated {
	
    [self.tableView reloadData];
	
}


// the right image for each cell

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	
    return UITableViewCellAccessoryDisclosureIndicator;
	
}


// Get the number of rows in the cell

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	
    tickyAppDelegate *appDelegate = (tickyAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    return appDelegate.projects.count;
	
}


// App calls this to populate the list table. It gets its number from numberOfRowsInSection

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"here");
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
	
    if (cell == nil) {
		
        // Create a new cell. CGRectZero allows the cell to determine the appropriate size.
		
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
		
    }
	
    // Retrieve the bookfile://localhost/Users/roykolak/Projects/Code/ticky/Classes/ListViewController.m object matching the row from the application delegate's array.
	
    tickyAppDelegate *appDelegate = (tickyAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    Project *project = (Project *)[appDelegate.projects objectAtIndex:indexPath.row];
	
	cell.text = project.name;
	
    return cell;
	
}


// Causes a transition on select of a row

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    tickyAppDelegate *appDelegate = (tickyAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    
	
	Project *project = [appDelegate.projects objectAtIndex:indexPath.row];
	
	[project hydrate];
	
	ActivityViewController *activityViewController = [[ActivityViewController alloc] init];
	[self.navigationController pushViewController:activityViewController animated:YES];
	[activityViewController setEditing:NO animated:NO];
	
	
    //showViewcontroller.project = project;
	
	
	
	
    return nil;
	
}


- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 

forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    tickyAppDelegate *appDelegate = (tickyAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    // If row is deleted, remove it from the list.
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
        // Find the book at the deleted row, and remove from application delegate's array.
		
        Project *project = [appDelegate.projects objectAtIndex:indexPath.row];
		
        [appDelegate removeProject:project];
		
        // Animate the deletion from the table.
		
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
		 
		 withRowAnimation:UITableViewRowAnimationFade];
	}
}
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
