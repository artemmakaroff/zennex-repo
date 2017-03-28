//
//  ServiceModel.h
//  TaskZennex
//
//  Created by Artem Makarov on 28.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (strong, nonatomic) NSString *idString;
@property (strong, nonatomic) NSString *descriptionString;
@property (strong, nonatomic) NSString *timeString;
@property (strong, nonatomic) NSString *ratingString;

- (id)initWithJSONResponse:(NSDictionary *)allKeysArray;

@end
