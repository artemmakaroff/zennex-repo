//
//  TypeBookkeepingViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 21.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "TypeBookkeepingViewController.h"
#import "AMTypeBookkeeping.h"
#import "TypeBookkeepingTableViewCell.h"

@interface TypeBookkeepingViewController ()

@end

@implementation TypeBookkeepingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AMTypeBookkeeping *typeBookkeeping = [[AMTypeBookkeeping alloc] init];
    
    self.bookkepingArray = [[NSArray alloc] init];
    self.bookkepingArray = [typeBookkeeping typesGroupArray];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.bookkepingArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *typeBookkeepingIdentifier = @"typeBookkeepingIdentifier";
    
    TypeBookkeepingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:typeBookkeepingIdentifier forIndexPath:indexPath];

    NSInteger row = indexPath.row;
    
    cell.typeBookkeepingLabel.text = self.bookkepingArray[row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    
    NSInteger row = indexPath.row;
    
    NSString *string = [NSString stringWithFormat:@"%@", self.bookkepingArray[row]];
    NSLog(@"%@", string);

    [self.delegate addTypeViewController:self didFinishEnterString:string];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
