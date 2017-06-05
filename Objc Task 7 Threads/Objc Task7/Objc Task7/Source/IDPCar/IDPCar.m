//
//  IDPCar.m
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCar.h"

#import "NSObject+IDPExtensions.h"

@interface IDPCar()
@property(nonatomic, assign) NSUInteger money;

@end

@implementation IDPCar

#pragma mark -
#pragma mark Initializations and Deallocation

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
        self.money = kIDPMoneyCount;
    
    return self;
}

- (NSUInteger)giveMoney {
    @synchronized (self) {
        NSUInteger tempMoney = self.money;
        self.money = 0;
        
        return tempMoney;
    }
}

- (void)takeMoney:(NSUInteger)money {
    @synchronized (self) {
        self.money += money;
    }
}

- (void)takeMoneyFromObject:(id<IDPCashFlow>)object {
    [self takeMoney:[object giveMoney]];
}

@end
