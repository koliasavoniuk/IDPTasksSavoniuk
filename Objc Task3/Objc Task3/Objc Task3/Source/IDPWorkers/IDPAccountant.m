//
//  IDPAccountant.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPAccountant.h"

#import "IDPWasher.h"

@implementation IDPAccountant

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(IDPWasher *)object {
    [self calculateMoney];
}

- (void)calculateMoney {
    NSLog(@"%@ counted the money, I have %lu$", self.name, self.money);
}

@end
