//
//  AddEmployeeViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "AddEmployeeViewController.h"
#import "TypeEmployeeViewController.h"
#import "TypeBookkeepingViewController.h"

@interface AddEmployeeViewController () <UITextFieldDelegate, TypeEmployeeViewControllerDelegate, TypeBookkeepingViewControllerDelegate>

@end

@implementation AddEmployeeViewController

static NSTimeInterval kAnimationDuration = 0.4;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Устанавливаем пустой лейбл для выбора бухгалтера
    self.positionLabelIsEmpty = YES;
    
    //Устанавливаем текст для время обеда/приёма
    
    //Создаём делегатов для текстовых полей
    self.nameTextField.delegate = self;
    self.salaryTextField.delegate = self;
    self.firstHoursTextField.delegate = self;
    self.secondHoursTextField.delegate = self;
    self.numberTextField.delegate = self;
    
    //Отключаем ячейку бухгалтера
    [self.bookkeepingCell setHidden:YES];
    
    //Подписываемся на нотификации клавиатуры
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notificationKeyboardWillShow:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notificationKeyboardWillHide:)
               name:UIKeyboardWillHideNotification
             object:nil];
    
    
    //Создание DatePicker для выбора часов начала обеда/приёма
    self.firstHourPicker = [[UIDatePicker alloc] init];
    
    [self.firstHourPicker setDatePickerMode:UIDatePickerModeTime];
    [self.firstHourPicker setDate:[NSDate date]];
   
    [self.firstHourPicker addTarget:self
                             action:@selector(updateFirstHoursTextField:)
                   forControlEvents:UIControlEventValueChanged];
    
    [self.firstHoursTextField setInputView:self.firstHourPicker];
    
    
    //Создание DatePicker для выбора часов окончания обеда/приёма
    self.secondHourPicker = [[UIDatePicker alloc] init];
    
    [self.secondHourPicker setDatePickerMode:UIDatePickerModeTime];
    [self.secondHourPicker setDate:[NSDate date]];
    
    [self.secondHourPicker addTarget:self
                              action:@selector(updateSecondHoursTextField:)
                    forControlEvents:UIControlEventValueChanged];
    
    [self.secondHoursTextField setInputView:self.secondHourPicker];
    
    
    //CGRect для всех ToolBar
    CGRect rectForToolBar = CGRectMake(0, 0, self.view.frame.size.width, 44);
    
    
    //Создание кнопки Done для firstHoursTextField
    UIToolbar *salaryToolBar = [[UIToolbar alloc] initWithFrame:rectForToolBar];
    [salaryToolBar setTintColor:[UIColor grayColor]];
    
    
    UIBarButtonItem *salaryDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(doneSalaryTextField:)];
    
    [salaryToolBar setItems:[NSArray arrayWithObjects:salaryDoneButton, nil]];
    [self.salaryTextField setInputAccessoryView:salaryToolBar];
    
    
    //Создание кнопки Done для firstHoursTextField
    UIToolbar *firstToollBar = [[UIToolbar alloc] initWithFrame:rectForToolBar];
    [firstToollBar setTintColor:[UIColor grayColor]];
    
    
    UIBarButtonItem *firstDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(doneFirstHoursTextField:)];
    
    [firstToollBar setItems:[NSArray arrayWithObjects:firstDoneButton, nil]];
    [self.firstHoursTextField setInputAccessoryView:firstToollBar];

    
    //Создание кнопки Done для secondHoursTextField
    UIToolbar *secondToollBar = [[UIToolbar alloc] initWithFrame:rectForToolBar];
    [secondToollBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *secondDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                         style:UIBarButtonItemStyleDone
                                                                        target:self
                                                                        action:@selector(doneSecondHoursTextField:)];
    
    [secondToollBar setItems:[NSArray arrayWithObjects:secondDoneButton, nil]];
    [self.secondHoursTextField setInputAccessoryView:secondToollBar];
    
    
    //Создание кнопки Done для numberEmployeeTextField
    UIToolbar *numberToolBar = [[UIToolbar alloc] initWithFrame:rectForToolBar];
    [secondToollBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *doneButtonNumberTextField = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                         style:UIBarButtonItemStyleDone
                                                                        target:self
                                                                        action:@selector(doneNumberTextField:)];
    
    [numberToolBar setItems:[NSArray arrayWithObjects:doneButtonNumberTextField, nil]];
    [self.numberTextField setInputAccessoryView:numberToolBar];
    
    
    //Создание жеста для отключения ввода текста по тапу в любое место кроме TextField's
    UITapGestureRecognizer *tapGestures = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestures];
    
}


//Метод для проверки заполнености полей
- (void)emptyTextFieldAndLabels
{
    NSInteger textLength = 1;
    
    if (self.positionLabel.text.length < textLength) {
        [self alertForEmptyDictionary];
        
    } else if (self.nameTextField.text.length < textLength) {
        [self alertForEmptyDictionary];
        
    } else if (self.salaryTextField.text.length < textLength) {
        [self alertForEmptyDictionary];
        
    } else if (self.firstHoursTextField.text.length < textLength) {
        [self alertForEmptyDictionary];
        
    } else if (self.secondHoursTextField.text.length < textLength) {
        [self alertForEmptyDictionary];
        
    } else if (self.numberTextField.text.length < textLength) {
        [self alertForEmptyDictionary];
        
    }  else if (self.typeBookkepingLabel.text.length < textLength && self.bookkeepingCell.hidden == NO) {
        [self alertForEmptyDictionary];
    
    } else {
        self.saveButton.backgroundColor = [UIColor blueColor];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Delegates

//Метод делегата передающий строку в typeBookkepingLabel
- (void)addTypeViewController:(TypeBookkeepingViewController *)controller didFinishEnterString:(NSString *)string
{
    self.typeBookkepingLabel.text = string;
}

//Метод делегата передающий строку в positionLabel и разрешающий редактировать текстовые поля
- (void)addItemViewController:(TypeEmployeeViewController *)controller didFinishEnteringItem:(NSString *)item
{
    self.positionLabel.text = item;
    
    self.positionLabelIsEmpty = NO;
    
    //Отключение ячейки выбора бухгалтерия, если выбран не бухгалтер
    if ([item isEqualToString:@"Бухгалтерия"]) {
        [self.bookkeepingCell setHidden:NO];

    } else {
        [self.bookkeepingCell setHidden:YES];
    }
    
    if ([item isEqualToString:@"Руководство"]) {
        self.hoursLabel.text = @"Часы приёма";
        
    } else {
        self.hoursLabel.text = @"Часы обеда";
    }
}

#pragma mark - Alerts

//Создаём Alert Message для пустых полей
- (void)alertForEmptyTextField
{
    UIAlertController *alertControllerEmptyTextFields = [UIAlertController alertControllerWithTitle:@"Пусто"
                                                                             message:@"Необходимо ввести значение, чтобы продолжить!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    
    [alertControllerEmptyTextFields addAction:alertAction];
    
    [self presentViewController:alertControllerEmptyTextFields animated:YES completion:nil];
    
}

- (void)alertForEmptyPositionLabel
{
    UIAlertController *alertControllerEmptyPositionLabel = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                             message:@"Необходимо выбрать тип сотрудника, чтобы продолжить!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    
    [alertControllerEmptyPositionLabel addAction:alertAction];
    
    [self presentViewController:alertControllerEmptyPositionLabel animated:YES completion:nil];
    
}

- (void)alertForEmptyDictionary
{
    UIAlertController *alertControllerEmptyDictionary = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                             message:@"Необходимо заполнить все поля!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    
    [alertControllerEmptyDictionary addAction:alertAction];
    
    [self presentViewController:alertControllerEmptyDictionary animated:YES completion:nil];
}

//Создаём закрытие для пустых текстовых полей
//- (void)closeAlertView
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - TapGestures

//Метод для жеста отключения ввода текста
- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

#pragma mark - Actions

//Action для кнопки сохранить
- (IBAction)saveButtonAction:(UIButton *)sender
{
    [self emptyTextFieldAndLabels];
    
    if ([self.positionLabel.text isEqualToString:@"Руководство"]) {
        self.managementDictionary = [[NSMutableDictionary alloc] init];
        
        [self.managementDictionary setValue:self.positionLabel.text forKey:@"position"];
        [self.managementDictionary setValue:self.nameTextField.text forKey:@"name"];
        [self.managementDictionary setValue:self.salaryTextField.text forKey:@"salary"];
        [self.managementDictionary setValue:self.firstHoursTextField.text forKey:@"firstHour"];
        [self.managementDictionary setValue:self.secondHoursTextField.text forKey:@"secondHour"];
        [self.managementDictionary setValue:self.numberTextField.text forKey:@"number"];
        
        //NSLog(@"Management Dictionary %@", self.managementDictionary);
        
        [self.delegate addEmployeeViewController:self endItemDictionary:self.managementDictionary];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if ([self.positionLabel.text isEqualToString:@"Сотрудники"]) {
        self.employeesDictionary = [[NSMutableDictionary alloc] init];
    
        [self.employeesDictionary setValue:self.positionLabel.text forKey:@"position"];
        [self.employeesDictionary setValue:self.nameTextField.text forKey:@"name"];
        [self.employeesDictionary setValue:self.salaryTextField.text forKey:@"salary"];
        [self.employeesDictionary setValue:self.firstHoursTextField.text forKey:@"firstHour"];
        [self.employeesDictionary setValue:self.secondHoursTextField.text forKey:@"secondHour"];
        [self.employeesDictionary setValue:self.numberTextField.text forKey:@"number"];
       // NSLog(@"Employees Dictionary %@", self.employeesDictionary);
    
        [self.delegate addEmployeeViewController:self endItemDictionary:self.employeesDictionary];
        [self.navigationController popViewControllerAnimated:YES];
    
    } else if ([self.positionLabel.text isEqualToString:@"Бухгалтерия"]) {
        self.bookkeepingDictionary = [[NSMutableDictionary alloc] init];
        
        [self.bookkeepingDictionary setValue:self.positionLabel.text forKey:@"position"];
        [self.bookkeepingDictionary setValue:self.nameTextField.text forKey:@"name"];
        [self.bookkeepingDictionary setValue:self.salaryTextField.text forKey:@"salary"];
        [self.bookkeepingDictionary setValue:self.firstHoursTextField.text forKey:@"firstHour"];
        [self.bookkeepingDictionary setValue:self.secondHoursTextField.text forKey:@"secondHour"];
        [self.bookkeepingDictionary setValue:self.numberTextField.text forKey:@"number"];
        [self.bookkeepingDictionary setValue:self.typeBookkepingLabel.text forKey:@"typeBookkeeping"];
        
        //NSLog(@"Bookkeeping Dictionary %@", self.bookkeepingDictionary);
        
        [self.delegate addEmployeeViewController:self endItemDictionary:self.bookkeepingDictionary];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        [self alertForEmptyDictionary];
    }

}

//Action для кнопки сохранить на tab bar controller
- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender
{
    [self saveButtonAction:self.saveButton];
}

- (IBAction)openTypeEmployeeViewController:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TypeEmployeeViewController *typeEmployeeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TypeEmployeeViewController"];
    
    typeEmployeeViewController.delegate = self;
    
    [self.navigationController pushViewController:typeEmployeeViewController animated:YES];
}

- (IBAction)typeBookkeepingButtonAction:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TypeBookkeepingViewController *typeBookkeepingViewController = [storyboard instantiateViewControllerWithIdentifier:@"TypeBookkeepingViewController"];

    typeBookkeepingViewController.delegate = self;
    
    [self.navigationController pushViewController:typeBookkeepingViewController animated:YES];
}

//Action для кнопки done salaryTextField
- (void)doneSalaryTextField:(UIBarButtonItem *)barButton
{
    if (self.salaryTextField.text.length > 0) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.firstHoursTextField becomeFirstResponder];
        }];
        
    } else {
        [self alertForEmptyTextField];
    }
}

//Action для кнопки done firstHoursTextField
- (void)doneFirstHoursTextField:(UIBarButtonItem *)barButton
{
    if (self.firstHoursTextField.text.length > 0) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.secondHoursTextField becomeFirstResponder];
        }];
        
    } else {
        [self alertForEmptyTextField];
    }
}

//Action для кнопки done secondHoursTextField
- (void)doneSecondHoursTextField:(UIBarButtonItem *)barButton
{
    if (self.secondHoursTextField.text.length > 0) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.numberTextField becomeFirstResponder];
        }];
        
    } else {
        [self alertForEmptyTextField];
    }
}

//Action для кнопки done secondHoursTextField
- (void)doneNumberTextField:(UIBarButtonItem *)barButton
{
    if (self.numberTextField.text.length > 0) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.numberTextField resignFirstResponder];
        }];
        
    } else {
        [self alertForEmptyTextField];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.nameTextField] && self.nameTextField.text.length > 0) {
        [self.salaryTextField becomeFirstResponder];
        
    } else {
        [self alertForEmptyTextField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.positionLabelIsEmpty == YES) {
        [self alertForEmptyPositionLabel];
        return NO;
        
    } else {
        return YES;
    }

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Создаём ограничения для строк с учётом что пользователь может использовать физическую клавиатуру, или копировать текст
    NSString *stringForNameTextField = @" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";
    NSString *stringForSalaryTextField = @"01234567890.";
    NSString *stringForFirstHoursTextField = @"01234567890:";
    NSString *stringForHoursTextField = @"01234567890:";
    NSString *stringForNumberTextField = @"1234567890";

    
    if ([textField isEqual:self.nameTextField]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString:stringForNameTextField] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }

    }
    
    if ([textField isEqual:self.salaryTextField]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString:stringForSalaryTextField] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
    }
    
    if ([textField isEqual:self.firstHoursTextField]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString:stringForFirstHoursTextField] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1 || string.length > 4) {
            return NO;
        }
        
    }
    
    if ([textField isEqual:self.secondHoursTextField]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString:stringForHoursTextField] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1 || string.length > 4) {
            return NO;
        }
        
    }
    
    if ([textField isEqual:self.numberTextField]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString:stringForNumberTextField] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
    }
    
    return YES;
}

//Методы для текстовых полей использующие DatePicker
- (void)updateFirstHoursTextField:(UIDatePicker *)picker
{
    self.firstHourPicker = (UIDatePicker*)self.firstHoursTextField.inputView;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *dateString = [[NSString alloc] init];
    dateString = [dateFormatter stringFromDate:self.firstHourPicker.date];
    
    self.firstHoursTextField.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)updateSecondHoursTextField:(UIDatePicker *)picker
{
    self.secondHourPicker = (UIDatePicker*)self.secondHoursTextField.inputView;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *dateString = [[NSString alloc] init];
    dateString = [dateFormatter stringFromDate:self.secondHourPicker.date];
    
    self.secondHoursTextField.text = [NSString stringWithFormat:@"%@",dateString];
}

#pragma mark - Notifications

- (void)notificationKeyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:kAnimationDuration animations: ^{
        CGRect frame = self.view.frame;
        frame.origin.y = -50;
        [self.view setFrame:frame];
    }];

}

- (void)notificationKeyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:kAnimationDuration animations: ^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        [self.view setFrame:frame];
    }];

}

@end
