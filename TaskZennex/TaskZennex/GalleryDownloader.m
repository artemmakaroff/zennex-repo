//
//  GalleryDownloader.m
//  TaskZennex
//
//  Created by Artem Makarov on 27.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "GalleryDownloader.h"
#import "GalleryModel.h"

@implementation GalleryDownloader

+ (GalleryDownloader *)parserManager
{
    static GalleryDownloader *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GalleryDownloader alloc] init];
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
    
    NSString *jsonBundle = [[NSBundle mainBundle] pathForResource:@"pictures"
                                                            ofType:@"json"];
    
    NSError *error = nil;
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonBundle
                                                           encoding:NSUTF8StringEncoding
                                                              error:&error];
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
    }
    
    NSArray *deserializedArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                                            options:0
                                                                              error:nil];

    NSMutableArray* objectsArray = [NSMutableArray array];
    
    for (NSDictionary* dict in deserializedArray) {
        GalleryModel* model = [[GalleryModel alloc] initWithJSONResponse:dict];
        [objectsArray addObject:model];
    }
    
    return objectsArray;
    
}


@end
