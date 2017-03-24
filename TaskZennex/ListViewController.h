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

@property (strong, nonatomic) NSMutableDictionary *managementDictionary;
@property (strong, nonatomic) NSMutableDictionary *employeeDictionary;
@property (strong, nonatomic) NSMutableDictionary *bookkeepingDictionary;

@property (weak, nonatomic) IBOutlet UIImageView *avatarLabel;

- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender;

@end
