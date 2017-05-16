//
//  NSArray+IDPCategory.h
//  IDPTask2
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPCategory)

+ (instancetype)objectsWithCount:(NSUInteger)count factoryBlock:(id(^)(void))block;

@end
