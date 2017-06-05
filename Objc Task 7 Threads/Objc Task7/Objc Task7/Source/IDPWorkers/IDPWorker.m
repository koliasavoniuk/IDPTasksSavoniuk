//
//  IDPWorker.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPWorker.h"

#import "IDPQueue.h"
#import "NSObject+IDPExtensions.h"

@interface IDPWorker()
@property (nonatomic, assign)   NSUInteger      experience;
@property (nonatomic, assign)   NSUInteger      money;
@property (nonatomic, retain)   IDPQueue        *workers;

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
    self.workers = [IDPQueue object];
        
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state {
    @synchronized (self) {
        IDPWorker *worker = [self.workers popObject];
        
        if (worker) {
            [self processObjectInBackground:worker];
            state = IDPWorkerBusy;
        } else {
            [super setState:state];
        }
        
        [super setState:state];
    }
}

/*- (void)setState:(NSUInteger)state {
    @synchronized (self) {
        [super setState:state];
        
        id object = [self.workers popObject];
        if (object) {
            [self processObject:object];
        }
    }
}*/

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObjectInBackground:(id)object {
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    
    [self performSelectorOnMainThread:@selector(performWorkWithObjectOnMain:)
                           withObject:object
                        waitUntilDone:NO];
}

- (void)processObjectInBackground:(id)object {
    [self performSelectorInBackground:@selector(performWorkWithObjectInBackground:)
                           withObject:object];
}

- (void)performWorkWithObjectOnMain:(id)object {
    [self finishProcessingObject:object];
    
    IDPQueue *queue = self.workers;
    @synchronized (self) {
        id queueObject = [queue popObject];
        
        if (queueObject) {
            [self performSelectorInBackground:@selector(performWorkWithObjectInBackground:)
                                   withObject:queueObject];
        } else {
            [self finishProcess];
        }
    }
}

- (void)processObject:(id)object {
    @synchronized (self) {
        if (self.state == IDPWorkerFree) {
            self.state = IDPWorkerBusy;
            [self performSelectorInBackground:@selector(performWorkWithObjectInBackground:)
                                   withObject:object];
        } else {
            [self.workers pushObject:object];
        }
    }
}

- (void)performWorkWithObject:(id)object {
    
}

- (void)finishProcess {
    self.state = IDPWorkerReadyForProcessing;
}

- (void)finishProcessingObject:(IDPWorker *)worker {
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
    @synchronized (self) {
        self.money += money;
    }
}

- (void)takeMoneyFromObject:(id<IDPCashFlow>)object {
    [self takeMoney:[object giveMoney]];
}

- (NSUInteger)giveMoney {
    @synchronized (self) {
        NSUInteger money = self.money;
        self.money = 0;
        
        return money;
    }
}

#pragma mark -
#pragma mark Implementation IDPWorkerObserver

- (void)workerDidBecomeReadyForProcessing:(IDPWorker *)worker; {
    [self processObject:worker];
}

@end
