//
//  ServiceViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 28.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceModel.h"
#import "ServiceDownloader.h"
#import "ServiceViewCell.h"

@interface ServiceViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self readDataFromJSON];
    
}

//Метод возращающий нам массив который мы получили из ServiceDownloader
- (void)readDataFromJSON
{
    ServiceDownloader *serviceDownloader = [ServiceDownloader parserManager];
    self.serviceArray = [serviceDownloader parsingJSON];
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

    return self.serviceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *serviceIdentifier = @"ServiceIdentifier";
    
    ServiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceIdentifier forIndexPath:indexPath];

    
    if (cell == nil) {
        cell = [[ServiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceIdentifier];
    }
    
    ServiceModel *serviceModel = [self.serviceArray objectAtIndex:indexPath.row];
    
    cell.idLabel.text = [NSString stringWithFormat:@"ID: %@", serviceModel.idString];
    cell.descriptionLabel.text = [NSString stringWithFormat:@"%@", serviceModel.descriptionString];
    cell.timeLabel.text = [NSString stringWithFormat:@"Время: %@", serviceModel.timeString];
    cell.ratingLabel.text = [NSString stringWithFormat:@"Рейтинг: %@", serviceModel.ratingString];
    
    return cell;
}


@end
