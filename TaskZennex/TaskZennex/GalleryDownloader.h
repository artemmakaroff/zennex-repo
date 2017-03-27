//
//  GalleryDownloader.h
//  TaskZennex
//
//  Created by Artem Makarov on 27.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryDownloader : NSObject

+ (GalleryDownloader *)parserManager;

- (NSArray *)parsingJSON;


@end
