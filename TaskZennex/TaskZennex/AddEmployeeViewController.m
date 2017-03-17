//
//  AddEmployeeViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "AddEmployeeViewController.h"

@interface AddEmployeeViewController () <UITextFieldDelegate>

@end

@implementation AddEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.nameTextField.delegate = self;
    //self.salaryTextField.delegate = self;
    self.hoursTextField.delegate = self;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)saveButtonAction:(UIButton *)sender {
}

- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender {
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.nameTextField]) {
        [self.salaryTextField becomeFirstResponder];
        
    } else if ([textField isEqual:self.salaryTextField]) {
        [self.hoursTextField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

//- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//    
//}

#pragma mark - Notifications

- (void) notificationKeyboardWillShow:(NSNotification*)notification
{
    NSLog(@"notificationKeyboardWillShow:\n%@", notification.userInfo);
}

- (void) notificationKeyboardWillHide:(NSNotification*)notification
{
    NSLog(@"notificationKeyboardWillHide:\n%@", notification.userInfo);
}

@end
