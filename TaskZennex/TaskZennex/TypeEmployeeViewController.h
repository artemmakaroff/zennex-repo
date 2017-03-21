//
//  TypeEmployeeViewController.h
//  TaskZennex
//
//  Created by Artem Makarov on 19.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeEmployeeViewControllerDelegate;

@interface TypeEmployeeViewController : UITableViewController

@property (strong, nonatomic) NSArray *positionArray;
@property (weak, nonatomic) IBOutlet UILabel *managementLabel;
@property (weak, nonatomic) IBOutlet UILabel *employeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *BokkeepingLabel;
@property (weak, nonatomic) id <TypeEmployeeViewControllerDelegate> delegate;

@end

@protocol TypeEmployeeViewControllerDelegate

- (void)addItemViewController:(TypeEmployeeViewController *)controller didFinishEnteringItem:(NSString *)item;

@end
