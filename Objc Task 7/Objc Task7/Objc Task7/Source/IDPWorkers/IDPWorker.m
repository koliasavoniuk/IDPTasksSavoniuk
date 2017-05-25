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
@property (nonatomic, assign)   IDPWorkerState  state;

@property (nonatomic, retain)     NSMutableArray  *observers;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [NSString stringWithFormat:@"%@ #%lu",
                 [self class],
                 IDPRandomTillNumber(kIDPSizeRandomNames)];
    self.experience = IDPRandomTillNumber(kIDPSizeRandomExperience);
    self.state = IDPWorkerFree;
    self.observers = [NSMutableArray array];
        
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(IDPWorkerState)state {
    _state = state;
    
    if (state == IDPWorkerReadyToProcess) {
        [self notifyObservers];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashFlow>)object {
    self.state = IDPWorkerBusy;
    
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    
    self.state = IDPWorkerReadyToProcess;
}

- (void)performWorkWithObject:(id)object {
    
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
#pragma mark Implementation IDPObserver

- (void)performWorkWithObservableObject:(id)observableObject {
    [self processObject:observableObject];
}

#pragma mark -
#pragma mark Implementation IDPObserver

- (void)addObserver:(id)observer {
    [self.observers addObject:observer];
}

- (void)deleteObserver:(id)observer {
    [self.observers removeObject:observer];
}

- (void)notifyObservers {
    for (id observer in self.observers) {
        [observer performWorkWithObservableObject:self];
    }
}

@end
