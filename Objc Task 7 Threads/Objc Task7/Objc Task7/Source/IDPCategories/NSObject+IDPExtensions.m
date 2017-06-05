//
//  NSObject+IDPExtension.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSObject+IDPExtensions.h"

#import "NSArray+IDPExtensions.h"

@implementation NSObject (IDPExtension)

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count
                        factoryBlock:^id{
        return [self object];
    }];
}

@end
