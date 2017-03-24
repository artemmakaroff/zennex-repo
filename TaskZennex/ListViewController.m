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
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        NSLog(@"%@", self.managementArray);
    

        [self.tableView reloadData];

    } else if ([[dictionary objectForKey:@"position"] isEqualToString:@"Сотрудники"]) {
        [self.employeeArray addObject:dictionary];
        NSLog(@"%@", self.managementArray);
        [self.tableView reloadData];
    }
//    } else if ([[dictionary objectForKey:@"position"] isEqualToString:@"Бухгалтерия"]) {
//        [self.bookkeepingArray addObject:dictionary];
//        NSLog(@"%@", self.managementArray);
//        [self.tableView reloadData];
//    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.managementArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    
    static NSString *reuseIdentfier = @"reuseIdentfier";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentfier forIndexPath:indexPath1];


    self.managementDictionary = [NSMutableDictionary dictionaryWithDictionary:self.managementArray[indexPath.row]];

    
    cell.nameLabel.text = [self.managementDictionary objectForKey:@"name"];
    cell.salaryLabel.text = [self.managementDictionary objectForKey:@"salary"];
    cell.firstHoursLabel.text = [self.managementDictionary objectForKey:@"firstHour"];
    cell.secondHoursLabel.text = [self.managementDictionary objectForKey:@"secondHour"];
    cell.numberLabel.text = [self.managementDictionary objectForKey:@"number"];
    cell.typeLabel.text = @"";
        
    
    
    return cell;
}

#pragma mark - Actions

- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddEmployeeViewController *addEmployeeViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddEmployeeViewController"];
    
    addEmployeeViewController.delegate = self;
    
    [self.navigationController pushViewController:addEmployeeViewController animated:YES];
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





