//
//  AMGroup.m
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "AMGroup.h"

@implementation AMGroup

- (NSArray *)employeesGroupArray
{
    AMGroup *group = [[AMGroup alloc] init];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Management", @"Employees", @"Bookkeeping", nil];
    
    group.employeesArray = array;
    
    return group.employeesArray;
}

@end
