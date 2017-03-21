//
//  AMTypeBookkeeping.h
//  TaskZennex
//
//  Created by Artem Makarov on 21.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMTypeBookkeeping : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSArray *typesArray;

- (NSArray *)typesGroupArray;

@end
