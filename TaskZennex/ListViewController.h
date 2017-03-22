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



- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender;

@end
