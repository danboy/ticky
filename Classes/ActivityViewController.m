//
//  ActivityViewController.m
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import "ActivityViewController.h"
#import "AddActivityViewController.h"


@implementation ActivityViewController
@synthesize tableView, addNavigationController;


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	self.title = @"Activities";
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(transitionToAddView:)];
	
	self.navigationItem.rightBarButtonItem = addButton;
	
	
}

- (void)transitionToAddView:(id)sender {
	
	AddActivityViewController *addActivityViewController=[[AddActivityViewController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addActivityViewController];
	self.addNavigationController=navController;
	[navController release];
	[self.navigationController presentModalViewController:addNavigationController animated:YES];
	[addActivityViewController setEditing:YES animated:NO];
	
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

    return cell;
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
