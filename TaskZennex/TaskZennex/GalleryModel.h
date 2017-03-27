//
//  GalleryModel.h
//  TaskZennex
//
//  Created by Artem Makarov on 27.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryModel : NSObject

@property (strong, nonatomic) NSString *sourceImageString;

- (id)initWithJSONResponse:(NSDictionary *)allKeysArray;

@end
