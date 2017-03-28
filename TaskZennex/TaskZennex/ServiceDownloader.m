//
//  ServiceDownloader.m
//  TaskZennex
//
//  Created by Artem Makarov on 28.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "ServiceDownloader.h"
#import "ServiceModel.h"

@implementation ServiceDownloader

+ (ServiceDownloader *)parserManager
{
    static ServiceDownloader *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServiceDownloader alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        [self parsingJSON];
    }
    
    return self;
}


- (NSArray *)parsingJSON
{
    
    NSError *error;
    NSString *urlString = [NSString stringWithFormat: @"http://quotes.zennex.ru/api/v3/bash/quotes?sort=time"];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];

    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSArray *jsonArray = [jsonObject objectForKey:@"quotes"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in jsonArray) {
        ServiceModel *serviceModel = [[ServiceModel alloc] initWithJSONResponse:dict];
        [array addObject:serviceModel];
        //NSLog(@"%@", array);
    }
    

    return array;
    
}



@end
