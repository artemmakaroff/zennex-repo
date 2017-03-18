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
@property (weak, nonatomic) IBOutlet UITextField *firstHoursTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondHoursTextField;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (strong, nonatomic) UIDatePicker *firstHourPicker;
@property (strong, nonatomic) UIDatePicker *secondHourPicker;

- (IBAction)saveButtonAction:(UIButton *)sender;
- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender;

@end
