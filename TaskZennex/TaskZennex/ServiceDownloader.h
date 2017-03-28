//
//  ServiceDownloader.h
//  TaskZennex
//
//  Created by Artem Makarov on 28.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceDownloader : NSObject

+ (ServiceDownloader *)parserManager;

- (NSArray *)parsingJSON;


@end
