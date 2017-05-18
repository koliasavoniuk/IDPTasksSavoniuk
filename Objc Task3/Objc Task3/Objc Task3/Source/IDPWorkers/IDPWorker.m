//
//  IDPWorker.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPWorker.h"

//static const NSString *kIDPResponsibility = @"responsibility";
//static const NSRange kIDPRangeSalary = { 500, 10000 };
//static const NSUInteger kIDPSizeRandomExperience = 30;

@interface IDPWorker()
@property (nonatomic, assign)   NSUInteger              experience;
@property (nonatomic, assign)   NSUInteger              salary;
@property (nonatomic, assign)   NSUInteger              money;
@property (nonatomic, assign)   IDPWorkerState          state;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    //self.name = nil;
    //self.responsibility = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [NSString stringWithFormat:@"%@ #%lu",
                 [self class],
                 IDPRandomTillNumber(kIDPSizeRandomNames)];
    self.experience = IDPRandomTillNumber(kIDPSizeRandomExperience);
    self.salary = IDPRandomWithRange(kIDPRangeSalary);
    //self.responsibility = [[kIDPResponsibility copy] autorelease];
    self.state = IDPWorkerFree;
        
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashFlow>)object {
    self.state = IDPWorkerBusy;
    [self performWorkWithObject:object];
    [self takeMoneyFromObject:object];
    self.state = IDPWorkerFree;
}

-(void)performWorkWithObject:(id)object {
    
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
    NSUInteger tempMoney = self.money;
    self.money = 0;
    
    return tempMoney;
}

@end
