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

@property (strong, nonatomic)NSMutableArray *dateArray;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionArray = [[NSArray alloc] init];
    
    AMGroup *group = [[AMGroup alloc] init];
    
    self.sectionArray = [group employeesGroupArray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWhenNewEmployee) name:@"NewEmployee" object:nil];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.managementArray = [NSMutableArray array];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableViewWhenNewEmployee
{
    
}

#pragma mark - Delegates
- (void)addEmployeeViewController:(AddEmployeeViewController *)controller endItemDictionary:(NSMutableDictionary *)dictionary
{
    [self.managementArray addObject:dictionary];

    NSLog(@"%@", self.managementArray);
    
    [self.tableView reloadData];

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
    
    static NSString *reuseIdentfier = @"reuseIdentfier";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentfier forIndexPath:indexPath];
    
    self.managementDictionary = [NSMutableDictionary dictionaryWithDictionary:self.managementArray[indexPath.row]];
    
    cell.nameLabel.text = [self.managementDictionary objectForKey:@"name"];
    cell.salaryLabel.text = [self.managementDictionary objectForKey:@"salary"];
    cell.firstHoursLabel.text = [self.managementDictionary objectForKey:@"firstHour"];
    cell.secondHoursLabel.text = [self.managementDictionary objectForKey:@"secondHour"];
    cell.numberLabel.text = [self.managementDictionary objectForKey:@"number"];
    
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





