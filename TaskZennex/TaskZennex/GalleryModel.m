//
//  GalleryModel.m
//  TaskZennex
//
//  Created by Artem Makarov on 27.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "GalleryModel.h"
#import "GalleryDownloader.h"

@implementation GalleryModel

- (id)initWithJSONResponse:(NSDictionary *)objectsArray
{
    self = [super init];
    
    if (self) {
        
        self.sourceImageString = [objectsArray objectForKey:@"source"];
    }
    
    return self;
}


@end
