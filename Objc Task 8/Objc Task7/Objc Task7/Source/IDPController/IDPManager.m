//
//  IDPManager.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPManager.h"

#import "IDPAccountant.h"
#import "IDPWasher.h"
#import "IDPDirector.h"
#import "IDPConstants.h"
#import "IDPQueue.h"
#import "IDPWorkerObserver.h"
#import "IDPDispatcher.h"

#import "NSArray+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

@interface IDPManager ()
@property (nonatomic, retain) NSMutableArray    *workers;
@property (nonatomic, retain) NSArray           *washers;
@property (nonatomic, retain) NSArray           *accountants;
@property (nonatomic, retain) IDPDirector       *director;
@property (nonatomic, retain) IDPQueue          *cars;
@property (nonatomic, retain) IDPDispatcher     *washerDispatcher;
@property (nonatomic, retain) IDPDispatcher     *accountantDispatcher;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.workers = nil;
    self.washers = nil;
    self.accountants = nil;
    self.director = nil;
    self.cars = nil;
    self.washerDispatcher = nil;
    self.accountantDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [NSMutableArray array];
    self.washers = [NSMutableArray array];
    self.accountants = [NSMutableArray array];
    self.director = [IDPDirector object];
    self.cars = [IDPQueue object];
    self.washerDispatcher = [IDPDispatcher object];
    self.accountantDispatcher = [IDPDispatcher object];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSMutableArray *)washers {
    @synchronized (self) {
        if (_washers) {
            for (IDPWasher *washer in _washers) {
                [washer deleteObservers:self.accountants];
            }
        }
        
        [washers retain];
        [_washers release];
        _washers = washers;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    IDPDispatcher *washerDispatcher = [IDPDispatcher object];
    IDPDispatcher *accountantDispatcher = [IDPDispatcher object];
    
    IDPDirector *director = self.director;
    [self.workers addObject:director];
    
    self.washers = [NSArray objectsWithCount:kIDPWashersCount factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        [washer addObservers:@[washerDispatcher, self]];
        [washerDispatcher addHandler:washer];
        
        [self.workers addObject:washer];
        self.washerDispatcher = washerDispatcher;
        
        return washer;
    }];
    
    self.accountants = [NSArray objectsWithCount:kIDPAccountantCount factoryBlock:^{
        IDPAccountant *accountant = [IDPAccountant object];
        [accountant addObservers:@[accountantDispatcher, director]];
        [accountantDispatcher addHandler:accountant];
        
        [self.workers addObject:accountant];
        self.accountantDispatcher = accountantDispatcher;
        
        return accountant;
    }];
    
}

- (void)processCars:(NSArray *)cars {
    for (IDPCar *car in cars) {
        [self processCar:car];
    }
}

- (void)processCar:(IDPCar *)car {
    [self.washerDispatcher processObject:car];
}

#pragma mark -
#pragma mark WorkerObserver methods

- (void)workerDidBecomeFree:(IDPWorker *)washer {
    IDPCar *car = [self.cars popObject];
        
    if (car) {
        [washer processObject:car];
    } else {
        [self.cars pushObject:washer];
    }
}

#pragma mark -
#pragma mark Private

- (id)freeWashers {
    return [self freeWorkersWithClass:[IDPWasher class]];
}

- (NSArray *)workersWithClass:(Class)cls {
    return [self.workers arrayByFilteringWithBlock:^BOOL(id object) {
        return [object isKindOfClass:[cls class]];
    }];
}

- (NSArray *)freeWorkersWithClass:(Class)class {
    @synchronized (self) {
        return [[self workersWithClass:class] arrayByFilteringWithBlock:^BOOL(IDPWorker *worker) {
            return  worker.state == IDPWorkerFree;
        }];
    }
}

- (id)freeWorkerWithClass:(Class)class {
    return [self freeWorkersWithClass:class].firstObject;
}

- (IDPQueue *)addCarsToQueue:(NSArray *)cars {
    IDPQueue *carsQueue = self.cars;
    
    for (id car in cars) {
        [carsQueue pushObject:car];
    }
    
    return carsQueue;
}

#pragma mark -
#pragma mark IDPWorkerObserver Implementation

- (void)workerDidBecomeReadyForProcessing:(id)worker {
    [self.accountantDispatcher processObject:worker];
}

@end
