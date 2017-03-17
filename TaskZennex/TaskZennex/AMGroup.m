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
    NSArray *array = [[NSArray alloc] initWithObjects:@"Management", @"Employees", @"Bookkeeping", nil];
    
    return array;
}

@end
