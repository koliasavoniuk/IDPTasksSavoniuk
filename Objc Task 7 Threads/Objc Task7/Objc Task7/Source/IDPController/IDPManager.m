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

@interface IDPManager ()
@property (nonatomic, retain) NSMutableArray    *washers;
@property (nonatomic, retain) NSMutableArray    *workers;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;
@property (nonatomic, retain) IDPQueue          *cars;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.washers = nil;
    self.workers = nil;
    self.accountant = nil;
    self.director = nil;
    self.cars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washers = [NSMutableArray array];
    self.workers = [NSMutableArray array];
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
    
    NSArray *washers = [IDPWasher objectsWithCount:IDPRandomTillNumber(kIDPSizeRandomWashers)];
    self.washers = [[washers copy] autorelease];
    NSMutableArray *workers = self.workers;
    IDPAccountant *accountant = [IDPAccountant object];
    IDPDirector *director = [IDPDirector object];
    
    for (IDPWasher *washer in washers) {
        [washer addObserver:accountant];
        [workers addObject:washer];
    }
    
    [accountant addObserver:director];
    
    [workers addObjectsFromArray:@[accountant,director]];
}

- (void)washCar:(IDPCar *)car {
    IDPWasher *washer = [self freeWasher];
    
    [washer processObject:car];
}
/*
 - (id)freeWasher {
     NSArray *washers = [self.washers arrayByFilteringWithBlock:^BOOL(IDPWasher *washer) {
         return washer.state == IDPWorkerFree;
     }];
     
     return [washers firstObject];
 }
*/
/*
- (id)freeWasher {
    NSArray *washers = self.washers;
    return [[self.washers freeWashers] firstObject];
}

- (id)freeWashers {
    NSArray *washers = [self.washers arrayByFilteringWithBlock:^BOOL(IDPWasher *washer) {
        return washer.state == IDPWorkerFree;
    }];
}
*/

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

#pragma mark -
#pragma mark Private

- (IDPQueue *)addCarsToQueue:(NSArray *)cars {
    IDPQueue *carsQueue = self.cars;
    
    for (id car in cars) {
        [carsQueue pushObject:car];
    }
    
    return carsQueue;
}

@end
