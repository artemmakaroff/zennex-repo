//
//  AddEmployeeViewController.h
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEmployeeViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *hoursTextField;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

- (IBAction)saveButtonAction:(UIButton *)sender;
- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender;

@end
