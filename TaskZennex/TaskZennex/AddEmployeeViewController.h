//
//  AddEmployeeViewController.h
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddEmployeeViewControllerDelegate;

@interface AddEmployeeViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstHoursTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondHoursTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeBookkepingLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *bookkeepingCell;

@property (strong, nonatomic) UIDatePicker *firstHourPicker;
@property (strong, nonatomic) UIDatePicker *secondHourPicker;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

@property (assign, nonatomic) BOOL positionLabelIsEmpty;
@property (assign, nonatomic) BOOL saveButtonIsOn;
@property (weak, nonatomic) id <AddEmployeeViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *managementDictionary;
@property (strong, nonatomic) NSMutableDictionary *employeesDictionary;
@property (strong, nonatomic) NSMutableDictionary *bookkeepingDictionary;

- (IBAction)saveButtonAction:(UIButton *)sender;
- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)openTypeEmployeeViewController:(UIButton *)sender;
- (IBAction)typeBookkeepingButtonAction:(UIButton *)sender;


@end

@protocol AddEmployeeViewControllerDelegate

- (void)addEmployeeViewController:(AddEmployeeViewController *)controller endItemDictionary:(NSMutableDictionary *)dictionary;

@end
