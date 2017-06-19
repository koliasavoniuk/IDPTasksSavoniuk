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

#import "NSArray+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"
#import "IDPWorkerObserver.h"

@interface IDPManager ()
@property (nonatomic, retain) NSMutableArray    *workers;
@property (nonatomic, retain) IDPQueue          *washers;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;
@property (nonatomic, retain) IDPQueue          *cars;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.workers = nil;
    self.washers = nil;
    self.accountant = nil;
    self.director = nil;
    self.cars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [NSMutableArray array];
    self.washers = [IDPQueue object];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    self.cars = [IDPQueue object];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    
    NSMutableArray *workers = [IDPWasher objectsWithCount:kIDPWashersCount];
    IDPAccountant *accountant = [IDPAccountant object];
    IDPDirector *director = [IDPDirector object];
    [accountant addObserver:director];
    
    for (IDPWasher *washer in workers) {
        [washer addObservers:@[accountant, self]];
        [self.washers pushObject:washer];
    }
    
    [workers addObjectsFromArray:@[accountant, director]];
    
    self.accountant = accountant;
    self.director = director;
    self.workers = workers;
}

- (void)processCars:(NSArray *)cars {
    IDPQueue *carsQueue = [self addCarsToQueue:cars];
    
    for (IDPCar *car in cars) {
        [self processCar:car];
    }
    
    self.cars = carsQueue;
}

- (void)processCar:(IDPCar *)car {
    @synchronized (self) {
        IDPWasher *washer = [self.washers popObject];
        
        if (washer) {
            [washer processObject:car];
        } else {
            [self.cars pushObject:car];
        }
    }
}

#pragma mark -
#pragma mark WorkerObserver methods

- (void)workerDidBecomeFree:(IDPWorker *)washer {
    @synchronized (self) {
        IDPCar *car = [self.cars popObject];
        
        if (car) {
            [washer processObject:car];
        } else {
            [self.cars pushObject:washer];
        }
    }
}

#pragma mark -
#pragma mark Private

- (id)freeWashers {
    @synchronized (self) {
        return [self freeWorkersWithClass:[IDPWasher class]];
    }
}

- (NSArray *)workersWithClass:(Class)cls {
    @synchronized (self.workers) {
        return [self.workers arrayByFilteringWithBlock:^BOOL(id object) {
            return [object isKindOfClass:[cls class]];
        }];
    }
}

- (NSArray *)freeWorkersWithClass:(Class)class {
    @synchronized (self.workers) {
        return [[self workersWithClass:class] arrayByFilteringWithBlock:^BOOL(IDPWorker *worker) {
            return  worker.state == IDPWorkerFree;
        }];
    }
}

- (id)freeWorkerWithClass:(Class)class {
    @synchronized (self) {
        return [self freeWorkersWithClass:class].firstObject;
    }
}

- (IDPQueue *)addCarsToQueue:(NSArray *)cars {
    IDPQueue *carsQueue = self.cars;
    
    for (id car in cars) {
        [carsQueue pushObject:car];
    }
    
    return carsQueue;
}

@end
