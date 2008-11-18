//
//  EditingViewController.m
//  ticky
//
//  Created by Pete Nawara on 11/17/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import "EditingViewController.h"


@implementation EditingViewController

@synthesize textField, project, editedFieldKey, textValue;

- (void)viewDidLoad {
	CGRect textFieldFrame = CGRectMake(0.0, 0.0, 300.0, 40.0);
	textField = [[UITextField alloc] initWithFrame:textFieldFrame];
	[textField setBorderStyle:UITextBorderStyleRoundedRect];
	[textField setTextColor:[UIColor blackColor]];
	[textField setDelegate:self];
	[textField setPlaceholder:@"<project name>"];
	//[textField setBackgroundColor:[UIColor whiteColor]];
	textField.keyboardType = UIKeyboardTypeDefault;
    textField.font = [UIFont systemFontOfSize:22];
	UIView *textFieldView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 300.0, 50.0)];
	[textFieldView addSubview:textField];
	[self.view addSubview:textFieldView];
	//self.view = textFieldView;
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
    /*
	// Adjust the text field size and font.

    // Set the view background to match the grouped tables in the other views.
    
	
    NSString *capitalizedKey = [editedFieldKey capitalizedString];
    self.title = capitalizedKey;
    textField.placeholder = capitalizedKey;
	
	textField.enabled = YES;
	textField.text = textValue;
	[textField becomeFirstResponder];
	 */
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
