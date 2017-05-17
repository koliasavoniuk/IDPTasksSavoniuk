//
//  IDPAccountant.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPAccountant.h"

static const NSRange kIDPRangeSalary = { 500, 7000};

@interface IDPAccountant ()
@property (nonatomic, assign)     NSInteger   salary;
@end

@implementation IDPAccountant

@dynamic salary;

#pragma mark -
#pragma mark Initializations and Reallocations

- (instancetype)init {
    self = [super init];
    self.salary = IDPRandomWithRange(kIDPRangeSalary);
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self countMoney];
}

- (void)countMoney {
    NSLog(@"%@ counted the money, I have %lu$", self.name, self.money);
}

@end
