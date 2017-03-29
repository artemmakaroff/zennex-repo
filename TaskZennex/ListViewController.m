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

static NSString *kSettingManagement     = @"management";
static NSString *kSettingEmployee       = @"employee";
static NSString *kSettingBookkeeping    = @"bookkeeping";
static NSString *kSettingPosition       = @"position";


static NSString *kSettingManagementDictionary     = @"managementDictionary";
static NSString *kSettingEmployeeDictionary       = @"employeeDictionary";
static NSString *kSettingBookkeepingDictionary    = @"bookkeepingDictionary";
static NSString *kSettingPositionDictionary       = @"positionDicitonary";

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sectionArray = [[NSArray alloc] init];
    
    AMGroup *group = [[AMGroup alloc] init];
    
    self.sectionArray = [group employeesGroupArray];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.editBarButton.title = @"Edit";
    
    self.managementArray = [NSMutableArray array];
    self.employeeArray = [NSMutableArray array];
    self.bookkeepingArray = [NSMutableArray array];
    
    self.managementDictionary = [NSMutableDictionary dictionary];
    self.employeeDictionary = [NSMutableDictionary dictionary];
    self.bookkeepingDictionary = [NSMutableDictionary dictionary];
    self.positionDictionary = [NSMutableDictionary dictionary];
    
    [self loadSettings];
}

#pragma mark - Save and Load

- (void)saveSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.managementArray forKey:kSettingManagement];
    [userDefaults setObject:self.employeeArray forKey:kSettingEmployee];
    [userDefaults setObject:self.bookkeepingArray forKey:kSettingBookkeeping];
    [userDefaults setObject:self.positionArray forKey:kSettingPosition];
    
    [userDefaults setObject:self.managementDictionary forKey:kSettingManagementDictionary];
    [userDefaults setObject:self.employeeDictionary forKey:kSettingEmployeeDictionary];
    [userDefaults setObject:self.bookkeepingDictionary forKey:kSettingBookkeepingDictionary];
    [userDefaults setObject:self.positionDictionary forKey:kSettingPositionDictionary];

    [userDefaults synchronize];
}

- (void)loadSettings
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    self.managementArray = [[userDefaults arrayForKey:kSettingManagement] mutableCopy];
    self.employeeArray = [[userDefaults arrayForKey:kSettingEmployee] mutableCopy];
    self.bookkeepingArray = [[userDefaults arrayForKey:kSettingBookkeeping] mutableCopy];
    self.positionArray = [[userDefaults arrayForKey:kSettingPosition] mutableCopy];
    
    self.managementDictionary = [[userDefaults dictionaryForKey:kSettingManagementDictionary] mutableCopy];
    self.employeeDictionary = [[userDefaults dictionaryForKey:kSettingEmployeeDictionary] mutableCopy];
    self.bookkeepingDictionary = [[userDefaults dictionaryForKey:kSettingBookkeepingDictionary] mutableCopy];
    self.positionDictionary = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kSettingPositionDictionary] mutableCopy];
    
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
        
        [self saveSettings];
        [self.tableView reloadData];
        

    } else if ([[dictionary objectForKey:@"position"] isEqualToString:@"Сотрудники"]) {
        [self.employeeArray addObject:dictionary];

        [self.positionDictionary setObject:self.employeeArray forKey:@"Сотрудники"];
        [self.positionArray addObject:self.positionDictionary];
        [self saveSettings];
        [self.tableView reloadData];
        
    
    } else if ([[dictionary objectForKey:@"position"] isEqualToString:@"Бухгалтерия"]) {
        [self.bookkeepingArray addObject:dictionary];

        [self.positionDictionary setObject:self.bookkeepingArray forKey:@"Бухгалтерия"];
        [self.positionArray addObject:self.positionDictionary];
        [self saveSettings];
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
    return [self.sectionArray objectAtIndex:section];
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
        cell.firstHoursLabel.text = [NSString stringWithFormat:@"Часы обеда с: %@ до: %@",
                                     [self.managementDictionary objectForKey:@"firstHour"], [self.managementDictionary objectForKey:@"secondHour"]];

        cell.numberLabel.text = [NSString stringWithFormat:@"№: %@", [self.managementDictionary objectForKey:@"number"]];
        
    } else if (indexPath.section == 1) {
        
        self.employeeDictionary = [NSMutableDictionary dictionaryWithDictionary:self.employeeArray[indexPath.row]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"ФИО: %@", [self.employeeDictionary objectForKey:@"name"]];
        cell.salaryLabel.text = [NSString stringWithFormat:@"Зарплата: %@", [self.employeeDictionary objectForKey:@"salary"]];
        cell.firstHoursLabel.text = [NSString stringWithFormat:@"Часы обеда с: %@ до: %@",
                                    [self.employeeDictionary objectForKey:@"firstHour"], [self.employeeDictionary objectForKey:@"secondHour"]];
        
        cell.numberLabel.text = [NSString stringWithFormat:@"№: %@", [self.employeeDictionary objectForKey:@"number"]];
    
    } else if (indexPath.section == 2) {
        
        self.bookkeepingDictionary = [NSMutableDictionary dictionaryWithDictionary:self.bookkeepingArray[indexPath.row]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"ФИО: %@", [self.bookkeepingDictionary objectForKey:@"name"]];
        cell.salaryLabel.text = [NSString stringWithFormat:@"Зарплата: %@", [self.bookkeepingDictionary objectForKey:@"salary"]];
        cell.firstHoursLabel.text = [NSString stringWithFormat:@"Часы обеда с: %@ до: %@" ,
                                    [self.bookkeepingDictionary objectForKey:@"firstHour"],[self.bookkeepingDictionary objectForKey:@"secondHour"]];
        
        cell.numberLabel.text = [NSString stringWithFormat:@"№: %@", [self.bookkeepingDictionary objectForKey:@"number"]];
        cell.typeLabel.text = [NSString stringWithFormat:@"Тип бухгалтера: %@", [self.bookkeepingDictionary objectForKey:@"typeBookkeeping"]];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [self.managementArray removeObjectAtIndex:indexPath.row];
            
            [self.tableView beginUpdates];
            [self saveSettings];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
            
        } else if (indexPath.section == 1) {
            [self.employeeArray removeObjectAtIndex:indexPath.row];
            
            [self.tableView beginUpdates];
            [self saveSettings];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
            
        } else if (indexPath.section == 2) {
            [self.bookkeepingArray removeObjectAtIndex:indexPath.row];
            
            [self.tableView beginUpdates];
            [self saveSettings];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
        }
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddEmployeeViewController *addEmployeeViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddEmployeeViewController"];

    addEmployeeViewController.delegate = self;
    
    [self.navigationController pushViewController:addEmployeeViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Удалить";
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    
    if (self.tableView.editing) {
        self.editBarButton.title = @"Done";
    } else if (!(self.tableView.editing)) {
        self.editBarButton.title = @"Edit";
    }

}

@end

