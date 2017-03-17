//
//  AMGroup.h
//  TaskZennex
//
//  Created by Artem Makarov on 17.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMGroup : NSObject

@property (strong, nonatomic) NSString *nameGroup;
@property (strong, nonatomic) NSArray *employeesArray;

- (NSArray *)employeesGroupArray;

@end
