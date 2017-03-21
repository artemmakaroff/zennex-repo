//
//  AMTypeBookkeeping.m
//  TaskZennex
//
//  Created by Artem Makarov on 21.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "AMTypeBookkeeping.h"

@implementation AMTypeBookkeeping

- (NSArray *)typesGroupArray
{
    AMTypeBookkeeping *bookkeeper = [[AMTypeBookkeeping alloc] init];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Начисление зарплаты", @"Учёт материалов", nil];
    
    bookkeeper.typesArray = array;
    
    return bookkeeper.typesArray;
}

@end
