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

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"
#import "IDPWorkerObserver.h"

@interface IDPManager ()
//@property (nonatomic, retain) NSMutableArray    *workers;
@property (nonatomic, retain) NSArray           *washers;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;
@property (nonatomic, retain) IDPQueue          *cars;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    //self.workers = nil;
    self.washers = nil;
    self.accountant = nil;
    self.director = nil;
    self.cars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    //self.workers = [NSMutableArray array];
    self.washers = [NSMutableArray array];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    self.cars = [IDPQueue object];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSMutableArray *)washers {
    if (_washers) {
        for (IDPWasher *washer in _washers) {
            [washer deleteObserver:self.accountant];
        }
    }
    
    _washers = washers;
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    
    IDPAccountant *accountant = self.accountant;
    IDPDirector *director = self.director;
    
    self.washers = [NSArray objectsWithCount:kIDPWashersCount factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        [washer addObserver:accountant];
        [washer addObserver:self];
        
        return washer;
    }];
    
    [accountant addObserver:director];
}

- (void)washCars:(NSArray *)cars {
    IDPQueue *carsQueue = [self addCarsToQueue:cars];
    NSArray *washers = self.washers;
    
    for (id washer in washers) {
        [washer processObject:[carsQueue popObject]];
    }
    
    self.cars = carsQueue;
}

#pragma mark -
#pragma mark WorkerObserver methods

- (void)workerDidBecomeFree:(IDPWorker *)washer {
    IDPCar *car = [self.cars popObject];
    
    if (car) {
        [washer processObject:car];
    }
}

#pragma mark -
#pragma mark Private

- (NSArray *)freeWashers {
    return [self.washers arrayByFilteringWithBlock:^BOOL(IDPWorker *washer) {
        return washer.state == IDPWorkerFree;
    }];
}

/*
- (id)freeWasher {
    return [self freeWorkerWithClass:[IDPWasher class]];
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
*/
- (IDPQueue *)addCarsToQueue:(NSArray *)cars {
    IDPQueue *carsQueue = self.cars;
    
    for (id car in cars) {
        [carsQueue pushObject:car];
    }
    
    return carsQueue;
}

@end
