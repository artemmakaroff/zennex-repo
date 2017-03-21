//
//  TypeBookkeepingViewController.h
//  TaskZennex
//
//  Created by Artem Makarov on 21.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeBookkeepingViewControllerDelegate;

@interface TypeBookkeepingViewController : UITableViewController

@property (strong, nonatomic) NSArray *bookkepingArray;
@property (weak, nonatomic) id <TypeBookkeepingViewControllerDelegate> delegate;

@end

@protocol TypeBookkeepingViewControllerDelegate

- (void)addTypeViewController:(TypeBookkeepingViewController *)controller didFinishEnterString:(NSString *)string;

@end
