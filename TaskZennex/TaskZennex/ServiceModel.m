//
//  ServiceModel.m
//  TaskZennex
//
//  Created by Artem Makarov on 28.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "ServiceModel.h"
#import "ServiceDownloader.h"

@implementation ServiceModel

- (id)initWithJSONResponse:(NSDictionary *)objectsArray
{
    self = [super init];
    
    if (self) {
        
        self.idString = [objectsArray objectForKey:@"id"];
        self.descriptionString = [objectsArray objectForKey:@"description"];
        self.timeString = [objectsArray objectForKey:@"time"];
        self.ratingString = [objectsArray objectForKey:@"rating"];
       
    }
    
    return self;
}

@end
