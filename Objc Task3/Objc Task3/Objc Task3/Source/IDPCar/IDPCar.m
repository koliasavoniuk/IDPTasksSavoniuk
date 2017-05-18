//
//  IDPCar.m
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCar.h"

//static const NSUInteger kIDPSizeRandomMoney = 1500;

@interface IDPCar()
@property(nonatomic, assign) NSUInteger money;

@end

@implementation IDPCar

#pragma mark -
#pragma mark Initializations and Reallocation

- (void)dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
        self.name = [NSString stringWithFormat:@"%@ #%lu",
                     [self class],
                     IDPRandomTillNumber(kIDPSizeRandomNames)];
        self.state = IDPCarDirty;
        self.money = IDPRandomTillNumber(kIDPSizeRandomMoney);
    
    return self;
}

- (NSUInteger)giveMoney {
    NSUInteger tempMoney = self.money;
    self.money = 0;
    return tempMoney;
}

- (void)takeMoney:(NSUInteger)money {
    self.money += money;
}

- (void)takeMoneyFromObject:(id<IDPCashFlow>)object {
    [self takeMoney:[object giveMoney]];
}

@end
