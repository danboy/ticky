//
//  EditingViewController.h
//  ticky
//
//  Created by Pete Nawara on 11/17/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"


@interface EditingViewController : UIViewController <UITextFieldDelegate> {
	UITextField *textField;
	Project *project;
    NSString *editedFieldKey;
    NSString *textValue;
}

@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,retain) Project *project;
@property (nonatomic, retain) NSString *editedFieldKey;
@property (nonatomic, retain) NSString *textValue;


@end
