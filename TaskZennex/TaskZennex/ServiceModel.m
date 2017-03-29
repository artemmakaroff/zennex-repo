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
        
        NSString *string = [[NSString alloc] init];
        string = [objectsArray objectForKey:@"description"];
        
        self.idString = [objectsArray objectForKey:@"id"];
        self.timeString = [objectsArray objectForKey:@"time"];
        self.ratingString = [objectsArray objectForKey:@"rating"];
       
        NSMutableString *stringForCharacterSet = [[NSMutableString alloc] initWithString:string];
        
        //Убираем мешающие символы
        NSCharacterSet *doNotWantCharacters = [NSCharacterSet characterSetWithCharactersInString:@"<br>&quot;&amp;#"];
        self.descriptionString = [[stringForCharacterSet componentsSeparatedByCharactersInSet:doNotWantCharacters] componentsJoinedByString:@""];
        }
    
    return self;
}
@end
