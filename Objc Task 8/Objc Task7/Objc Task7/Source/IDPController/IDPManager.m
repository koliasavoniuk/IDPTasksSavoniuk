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
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [NSMutableArray array];
    self.washers = [NSMutableArray array];
    self.accountants = [NSMutableArray array];
    self.director = [IDPDirector object];
    self.cars = [IDPQueue object];
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
/*
- (void)buildCarWash {
    
    IDPAccountant *accountant = self.accountant;
    IDPDirector *director = self.director;
    
    [self.workers addObjectsFromArray:@[accountant,director]];
    
    self.washers = [NSArray objectsWithCount:kIDPWashersCount factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        [washer addObserver:accountant];
        [washer addObserver:self];
        
        [self.workers addObject:washer];
        
        return washer;
    }];
    
    [accountant addObserver:director];
}
*/

- (void)buildCarWash {
    IDPDispatcher *washerDispatcher = [IDPDispatcher object];
    IDPDispatcher *accountantDispatcher = [IDPDispatcher object];
    
    //IDPAccountant *accountant = self.accountant;
    IDPDirector *director = self.director;
    [self.workers addObject:director];
    
    self.washers = [NSArray objectsWithCount:kIDPWashersCount factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        [washer addObservers:@[washerDispatcher, self]];
        [washerDispatcher addHandler:washer];
        //[washer addObserver:self];
        
        [self.workers addObject:washer];
        
        return washer;
    }];
    
    self.accountants = [NSArray objectsWithCount:kIDPAccountantCount factoryBlock:^{
        IDPAccountant *accountant = [IDPAccountant object];
        [accountant addObservers:@[accountantDispatcher, director]];
        [accountantDispatcher addHandler:accountant];
        //[accountant addObserver:self];
        
        [self.workers addObject:accountant];
        
        return accountant;
    }];
    
}

- (void)processCars:(NSArray *)cars {
    IDPQueue *carsQueue = [self addCarsToQueue:cars];
    
    for (IDPCar *car in cars) {
        [self processCar:car];
    }
    
    self.cars = carsQueue;
}

- (void)processCar:(IDPCar *)car {
    NSArray *washers = [self freeWashers];
    
    for (id washer in washers) {
        [washer processObject:car];
    }
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

@end
