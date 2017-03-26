//
//  ListViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "ListViewController.h"
#import "AMGroup.h"
#import "AddEmployeeViewController.h"
#import "ListTableViewCell.h"

@interface ListViewController () <AddEmployeeViewControllerDelegate>

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionArray = [[NSArray alloc] init];
    
    AMGroup *group = [[AMGroup alloc] init];
    
    self.sectionArray = [group employeesGroupArray];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.managementArray = [NSMutableArray array];
    self.employeeArray = [NSMutableArray array];
    self.bookkeepingArray = [NSMutableArray array];
    
    self.positionDictionary = [NSMutableDictionary dictionary];
    self.positionArray = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegates
- (void)addEmployeeViewController:(AddEmployeeViewController *)controller endItemDictionary:(NSMutableDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"position"] isEqualToString:@"Руководство"]) {
        [self.managementArray addObject:dictionary];

        [self.positionDictionary setObject:self.managementArray forKey:@"Руководство"];
        [self.positionArray addObject:self.positionDictionary];
        [self.tableView reloadData];

    } else if ([[dictionary objectForKey:@"position"] isEqualToString:@"Сотрудники"]) {
        [self.employeeArray addObject:dictionary];

        [self.positionDictionary setObject:self.employeeArray forKey:@"Сотрудники"];
        [self.positionArray addObject:self.positionDictionary];
        [self.tableView reloadData];
    
    } else if ([[dictionary objectForKey:@"position"] isEqualToString:@"Бухгалтерия"]) {
        [self.bookkeepingArray addObject:dictionary];

        [self.positionDictionary setObject:self.bookkeepingArray forKey:@"Бухгалтерия"];
        [self.positionArray addObject:self.positionDictionary];
        [self.tableView reloadData];
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.positionArray.count < 1) {
        return @"";
    } else {
    
    return [self.sectionArray objectAtIndex:section];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.managementArray.count;
            break;
        case 1:
            return self.employeeArray.count;
            break;
        case 2:
            return self.bookkeepingArray.count;
            break;
    }
    
    return section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentfier = @"reuseIdentfier";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentfier forIndexPath:indexPath];

    if (indexPath.section == 0) {
        self.managementDictionary = [NSMutableDictionary dictionaryWithDictionary:self.managementArray[indexPath.row]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"ФИО: %@", [self.managementDictionary objectForKey:@"name"]];
        cell.salaryLabel.text = [NSString stringWithFormat:@"Зарплата: %@", [self.managementDictionary objectForKey:@"salary"]];
        cell.firstHoursLabel.text = [NSString stringWithFormat:@"Часы приёма с: %@", [self.managementDictionary objectForKey:@"firstHour"]];
        cell.secondHoursLabel.text = [NSString stringWithFormat:@"до: %@", [self.managementDictionary objectForKey:@"secondHour"]];
        cell.numberLabel.text = [NSString stringWithFormat:@"№: %@", [self.managementDictionary objectForKey:@"number"]];
        
    } else if (indexPath.section == 1) {
        
        self.employeeDictionary = [NSMutableDictionary dictionaryWithDictionary:self.employeeArray[indexPath.row]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"ФИО: %@", [self.employeeDictionary objectForKey:@"name"]];
        cell.salaryLabel.text = [NSString stringWithFormat:@"Зарплата: %@", [self.employeeDictionary objectForKey:@"salary"]];
        cell.firstHoursLabel.text = [NSString stringWithFormat:@"Часы обеда с: %@", [self.employeeDictionary objectForKey:@"firstHour"]];
        cell.secondHoursLabel.text = [NSString stringWithFormat:@"до: %@", [self.employeeDictionary objectForKey:@"secondHour"]];
        cell.numberLabel.text = [NSString stringWithFormat:@"№: %@", [self.employeeDictionary objectForKey:@"number"]];
    
    } else if (indexPath.section == 2) {
        
        self.bookkeepingDictionary = [NSMutableDictionary dictionaryWithDictionary:self.bookkeepingArray[indexPath.row]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"ФИО: %@", [self.bookkeepingDictionary objectForKey:@"name"]];
        cell.salaryLabel.text = [NSString stringWithFormat:@"Зарплата: %@", [self.bookkeepingDictionary objectForKey:@"salary"]];
        cell.firstHoursLabel.text = [NSString stringWithFormat:@"Часы обеда с: %@", [self.bookkeepingDictionary objectForKey:@"firstHour"]];
        cell.secondHoursLabel.text = [NSString stringWithFormat:@"до: %@", [self.bookkeepingDictionary objectForKey:@"secondHour"]];
        cell.numberLabel.text = [NSString stringWithFormat:@"№: %@", [self.bookkeepingDictionary objectForKey:@"number"]];
        cell.typeLabel.text = [NSString stringWithFormat:@"Тип бухгалтера: %@", [self.bookkeepingDictionary objectForKey:@"typeBookkeeping"]];

    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    } else  if (indexPath.section == 1) {
        return 100;
    } else if (indexPath.section == 2) {
        return 130;
    }

    return indexPath.section;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    
}

#pragma mark - Actions

- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddEmployeeViewController *addEmployeeViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddEmployeeViewController"];
    
    addEmployeeViewController.delegate = self;
    
    [self.navigationController pushViewController:addEmployeeViewController animated:YES];
}

- (IBAction)editBarButtonAction:(UIBarButtonItem *)sender
{
    BOOL isEditing = self.tableView.editing;
        
    [self.tableView setEditing:!isEditing animated:YES];
}

//
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//// Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
// // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
// 
//
//
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//}
//
//
//
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//// Return NO if you do not want the item to be re-orderable.
//return YES;
//}

@end





