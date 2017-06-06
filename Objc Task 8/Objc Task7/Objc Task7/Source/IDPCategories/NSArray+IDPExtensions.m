//
//  NSArray+IDPCategory.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSArray+IDPExtensions.h"

@implementation NSArray (IDPCategory)

+ (instancetype)objectsWithCount:(NSUInteger)count factoryBlock:(id(^)(void))block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [array addObject: block()];
    }
    
    return  array;
}

- (NSArray *)arrayByFilteringWithBlock:(BOOL(^)(id object))block {
    if (!block) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *buildings) {
        return block(object);
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

@end
