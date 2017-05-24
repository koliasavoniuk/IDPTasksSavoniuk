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

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

@interface IDPManager ()
@property (nonatomic, retain)   NSMutableArray  *workers;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.workers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [NSMutableArray array];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    
    NSArray *washers = [IDPWasher objectsWithCount:IDPRandomTillNumber(kIDPSizeRandomWashers)];
    washers = [[washers copy] autorelease];
    IDPAccountant *accountant = [IDPAccountant object];
    IDPDirector *director = [IDPDirector object];
    
    for (IDPWasher *washer in washers) {
        washer.delegate = accountant;
        [self.workers addObject:washer];
    }
    accountant.delegate = director;
    
    [self.workers addObjectsFromArray:@[accountant, director]];
}

- (void)washCar:(IDPCar *)car {
    IDPWasher *washer = [self freeWasher];
    
    [washer processObject:car];
}

 - (id)freeWasher {
 return [self freeWorkerWithClass:[IDPWasher class]];
 }
 
 - (id)workersWithClass:(Class)cls {
 NSArray *workers =  [self.workers arrayByFilteringWithBlock:^BOOL(id object) {
 return [object isKindOfClass:[cls class]];
 }];
 
 return [[workers copy] autorelease];
 }
 
 - (id)freeWorkersWithClass:(Class)class {
 return [[self workersWithClass:class] arrayByFilteringWithBlock:^BOOL(IDPWorker *worker) {
 return  worker.state == IDPWorkerFree;
 }];
 }
 
 - (id)freeWorkerWithClass:(Class)class {
 return [[self freeWorkersWithClass:class] firstObject];
 }

@end
