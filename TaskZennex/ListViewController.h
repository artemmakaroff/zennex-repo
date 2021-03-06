//
//  ListViewController.h
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController

@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) NSMutableArray *managementArray;
@property (strong, nonatomic) NSMutableArray *employeeArray;
@property (strong, nonatomic) NSMutableArray *bookkeepingArray;
@property (strong, nonatomic) NSMutableArray *positionArray;

@property (strong, nonatomic) NSMutableDictionary *managementDictionary;
@property (strong, nonatomic) NSMutableDictionary *employeeDictionary;
@property (strong, nonatomic) NSMutableDictionary *bookkeepingDictionary;
@property (strong, nonatomic) NSMutableDictionary *positionDictionary;

@property (strong, nonatomic) NSArray *sortedManagementArray;
@property (strong, nonatomic) NSArray *sortedEmployeeArray;
@property (strong, nonatomic) NSArray *sortedBookkeepingArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBarButton;

- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)editBarButtonAction:(UIBarButtonItem *)sender;

- (void)saveSettings;
- (void)loadSettings;

@end
