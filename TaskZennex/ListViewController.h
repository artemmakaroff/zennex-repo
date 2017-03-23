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
@property (strong, nonatomic) NSMutableDictionary *managementDictionary;
@property (weak, nonatomic) IBOutlet UIImageView *avatarLabel;

@property (strong, nonatomic) NSString *positionString;
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSString *salaryString;
@property (strong, nonatomic) NSString *firstHoursString;
@property (strong, nonatomic) NSString *secondHoursString;
@property (strong, nonatomic) NSString *numberString;
@property (strong, nonatomic) NSString *typeBookkeepingString;

- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender;

@end
