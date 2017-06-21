//
//  IDPRandom.m
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPRandom.h"

NSUInteger IDPRandomTillNumber(NSUInteger number) {
    return arc4random_uniform((uint32_t)number + 1);
}

NSUInteger IDPRandomBool() {
    return IDPRandomTillNumber(1);
}

NSUInteger IDPRandomWithRange(NSRange range) {
    return IDPRandomTillNumber(range.length) + range.location;
}
