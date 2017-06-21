//
//  IDPWorker.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPWorker.h"

@interface IDPWorker()
@property (nonatomic, assign)   NSUInteger      experience;
@property (nonatomic, assign)   NSUInteger      money;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.name = [NSString stringWithFormat:@"%@ #%lu",
                 [self class],
                 IDPRandomTillNumber(kIDPSizeRandomNames)];
    self.experience = IDPRandomTillNumber(kIDPSizeRandomExperience);
    self.state = IDPWorkerFree;
        
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(IDPWorkerState)state {
    _state = state;
    
    if (state == IDPWorkerReadyForProcessing) {
        [self.delegate workerDidBecomeReadyForProcessing:self];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id)object {
    self.state = IDPWorkerBusy;
    
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    
    [self finishProcessingObject:object];
    [self finishProcess];
}

- (void)performWorkWithObject:(id)object {
    
}

- (void)finishProcess {
    self.state = IDPWorkerReadyForProcessing;
}

- (void)finishProcessingObject:(IDPWorker *)object {
    object.state = IDPWorkerFree;
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
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
}

#pragma mark -
#pragma mark Implementation IDPWorkerDelegate

- (void)workerDidBecomeReadyForProcessing:(id)object {
    [self processObject:object];
}

@end
