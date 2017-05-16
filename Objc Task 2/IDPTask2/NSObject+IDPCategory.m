//
//  NSObject+IDPCategory.m
//  IDPTask2
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//
#import "IDPHuman.h"

#import "NSObject+IDPCategory.h"
#import "NSArray+IDPCategory.h"

@implementation NSObject (IDPCategory)

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count factoryBlock:^id {
        return [IDPHuman object];
    }];
}

- (instancetype)object {
    return [[[self alloc] init] autorelease];
}

@end
