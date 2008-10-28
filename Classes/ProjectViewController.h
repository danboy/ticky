//
//  ProjectViewController.h
//  ticky
//
//  Created by Pete Nawara on 10/27/08.
//  Copyright 2008 petenawara.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

@interface ProjectViewController : UITableViewController {
UINavigationController *addNavigationController;

}

@property (nonatomic, retain) UINavigationController *addNavigationController;

@end
