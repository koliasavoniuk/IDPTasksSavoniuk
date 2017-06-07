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
@property (nonatomic, retain) IDPDispatcher     *washersDispatcher;
@property (nonatomic, retain) IDPDispatcher     *accountantsDispatcher;
@property (nonatomic, retain) IDPDispatcher     *directorDispatcher;

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
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [NSMutableArray array];
    self.washers = [NSMutableArray array];
    self.accountants = [NSMutableArray array];
    self.director = [IDPDirector object];
    self.cars = [IDPQueue object];
    self.washersDispatcher = [IDPDispatcher object];
    self.accountantsDispatcher = [IDPDispatcher object];
    self.directorDispatcher = [IDPDispatcher object];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSMutableArray *)washers {
    if (_washers) {
        for (IDPWasher *washer in _washers) {
            [washer deleteObservers:self.accountants];
        }
    }
    
    [washers retain];
    [_washers release];
    _washers = washers;
}

#pragma mark -
#pragma mark Public Methods

- (void)processCars:(NSArray *)cars {
    for (IDPCar *car in cars) {
        [self processCar:car];
    }
}

- (void)processCar:(IDPCar *)car {
    [self.washersDispatcher processObject:car];
}

#pragma mark -
#pragma mark Private

typedef id(^IDPDispatcherFactory)(Class handlerClass, NSUInteger handlerCount, id observer);

- (void)buildCarWash {
    IDPDispatcherFactory factory = ^id(Class handlerClass, NSUInteger handlerCount, id observer) {
        id dispatcher = [IDPDispatcher object];
        id handlers = [NSArray objectsWithCount:handlerCount factoryBlock:^{
            id handler = [handlerClass object];
            [handler addObservers:observer];
            
            return handler;
        }];
        
        [dispatcher addHandlers:handlers];
        
        return dispatcher;
    };
    IDPDispatcher *directorDispatcher = factory([IDPDirector class], 1, nil);
    IDPDispatcher *accountantsDispatcher = factory([IDPAccountant class], kIDPAccountantCount, @[directorDispatcher]);
    IDPDispatcher *washersDispatcher = factory([IDPWasher class],kIDPWashersCount, @[accountantsDispatcher]);
    
    self.washersDispatcher = washersDispatcher;
    self.accountantsDispatcher = accountantsDispatcher;
    self.directorDispatcher = directorDispatcher;
}

- (id)freeWashers {
    return [self freeWorkersWithClass:[IDPWasher class]];
}

- (NSArray *)workersWithClass:(Class)cls {
    return [self.workers arrayByFilteringWithBlock:^BOOL(id object) {
        return [object isKindOfClass:[cls class]];
    }];
}

- (NSArray *)freeWorkersWithClass:(Class)class {
    @synchronized (self.workers) {
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
    [self.accountantsDispatcher processObject:worker];
}

@end
