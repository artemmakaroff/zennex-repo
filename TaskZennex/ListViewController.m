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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWhenNewEmployee) name:@"NewEmployee" object:nil];
   // self.managementArray = [[NSMutableArray alloc] init];
    
   
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewEmployee" object:nil];
    
    if ([[dictionary objectForKey:@"position"] isEqualToString:@"Руководство"]) {
        self.managementDictionary = [[NSMutableDictionary alloc] init];
        self.managementDictionary = dictionary;
        ListTableViewCell *cell = [[ListTableViewCell alloc] init];
        cell.nameLabel = [self.managementDictionary objectForKey:@"name"];
        
        self.managementArray = [[NSMutableArray alloc] init];
        [self.managementArray addObject:self.managementDictionary];
        NSLog(@"array %@", self.managementArray);
        NSLog(@"Dictionary %@", self.managementDictionary);
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
    return self.managementArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentfier = @"reuseIdentfier";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentfier forIndexPath:indexPath];
    
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
@end





