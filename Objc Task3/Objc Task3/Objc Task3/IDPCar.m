//
//  IDPCar.m
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCar.h"

@interface IDPCar()
@property(nonatomic, assign, getter=money) NSUInteger money;
@property(nonatomic, assign) IDPState state;
@end

@implementation IDPCar

#pragma mark -
#pragma mark Initializations and Reallocation

- (void) dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if(self) {
        self.name = [NSString stringWithFormat:@"%@ #%lu",
                     [self class],
                     IDPRandomTillNumber(kIDPSizeRandomNames)];
        self.state = IDPDirty;
        self.money = IDPRandomTillNumber(kIDPSizeRandomMany);

    }
    
    return self;
}

- (void)changeState:(IDPState)state {
    self.state = state;
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
