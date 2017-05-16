//
//  IDPWorker.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPWorker.h"

@interface IDPWorker()
@property (nonatomic, assign)   NSUInteger              experience;
@property (nonatomic, assign)   NSUInteger              salary;
@property (nonatomic, copy)     NSString                *responsibility;
@property (nonatomic, assign)   NSUInteger              money;
@property (nonatomic, assign)   IDPStateOfEmployee    state;

@end

static const NSString *kIDPResponsibility = @"responsibility";
static const NSRange kIDPRangeSalary = { 500, 10000 };
static const int kIDPSizeRandomExperience = 30;

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    self.name = nil;
    self.responsibility = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
    self.name = [NSString stringWithFormat:@"%@ #%lu",
                 [self class],
                 IDPRandomTillNumber(kIDPSizeRandomNames)];
    self.experience = IDPRandomTillNumber(kIDPSizeRandomExperience);
    self.salary = IDPRandomWithRange(kIDPRangeSalary);
    self.responsibility = [[kIDPResponsibility copy] autorelease];
    self.state = IDPFree;
    }
        
    return self;
    }

#pragma mark -
#pragma mark Public Methods

- (NSUInteger) money {
    return _money;
}

- (void)processObject:(id<IDPCashFlow>)object {
    [self changeState];
    [self makeWork:object];
    [self takeMoney:[object giveMoney]];
    [self changeState];
}

-(void)makeWork:(id)object {
    
}

- (void)changeState {
    self.state = (self.state == IDPFree) ? IDPBusy : IDPFree;
}

#pragma mark -
#pragma mark Implementation IDPCashFlow

- (void)takeMoney:(NSUInteger)money {
    self.money += money;
}

- (void)takeMoneyFromObject:(id<IDPCashFlow>)object {
    [self takeMoney:[object giveMoney]];
}

- (NSUInteger)giveMoney {
    NSUInteger temp = self.money;
    self.money = 0;
    return temp;
}

@end
