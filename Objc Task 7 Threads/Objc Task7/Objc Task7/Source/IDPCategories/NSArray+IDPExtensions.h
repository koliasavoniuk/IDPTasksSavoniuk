//
//  NSArray+IDPCategory.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPCategory)

+ (instancetype)objectsWithCount:(NSUInteger)count factoryBlock:(id(^)(void))block;

- (NSArray *)arrayByFilteringWithBlock:(BOOL(^)(id object))block;

@end
