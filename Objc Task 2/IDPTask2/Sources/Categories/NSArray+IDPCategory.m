//
//  NSArray+IDPCategory.m
//  IDPTask2
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSArray+IDPCategory.h"

@implementation NSArray (IDPCategory)

+ (instancetype)objectsWithCount:(NSUInteger)count factoryBlock:(id(^)(void))block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < count; i++) {
        [array addObject:block()];
    }
    
    return [self arrayWithArray:array];
}

@end
