//
//  TypeEmployeeViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 19.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "TypeEmployeeViewController.h"
#import "AddEmployeeViewController.h"
#import "TypeEmployeeViewCell.h"
#import "AMGroup.h"

@interface TypeEmployeeViewController ()

@end

@implementation TypeEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.positionArray = [[NSArray alloc] init];
    
    AMGroup *group = [[AMGroup alloc] init];
    
    self.positionArray = [[NSArray alloc] init];
    self.positionArray = [group employeesGroupArray];
    
    NSString *itemToPassBack = @"Pass this value back to ViewControllerA";
    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.positionArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentfier = @"reuseIdentfier";
    
    TypeEmployeeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentfier forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;

    cell.positionLabel.text = self.positionArray[row];
    
    return cell;
}

@end
