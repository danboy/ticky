//
//  AddActivityViewController.h
//  ticky
//
//  Created by Pete Nawara on 11/17/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddActivityViewController : UIViewController {
	UITableView *activityView;
	UITextField *textField;
}

@property (nonatomic, retain) UITableView *activityView;
@property (nonatomic, retain) UITextField *textField;

@end
