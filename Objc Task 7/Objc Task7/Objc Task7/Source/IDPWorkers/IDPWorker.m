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
//@property (nonatomic, assign)   IDPWorkerState  state;
//@property (nonatomic, retain)     NSMutableArray  *observers;

@end

@implementation IDPWorker

@synthesize state = _state;

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

- (void)setState:(NSUInteger)state {
    _state = state;
    
    [self notifyOfState:state];
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id)object {
    self.state = IDPWorkerBusy;
    
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    
    [self workerDidFinishProcessingObject:object];
    [self finishingProcessObject];
}

- (void)performWorkWithObject:(id)object {
    
}

- (void)finishingProcessObject {
    self.state = IDPWorkerReadyForProcessing;
}

- (void)workerDidFinishProcessingObject:(IDPWorker *)worker {
    worker.state = IDPWorkerFree;
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPWorkerFree:
            return @selector(workerDidBecomeFree:);
        case IDPWorkerBusy:
            return @selector(workerDidBecomeBusy:);
        case IDPWorkerReadyForProcessing:
            return @selector(workerDidBecomeReadyForProcessing:);
            
        default:
            return [super selectorForState:state];
    }
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
#pragma mark Implementation IDPWorkerObserver

- (void)workerDidBecomeReadyForProcessing:(IDPWorker *)worker; {
    [self processObject:worker];
}

@end
