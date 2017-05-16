//
//  IDPRoom.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPRoom.h"
#import "IDPRandom.h"

@interface IDPRoom ()
@property (nonatomic, retain)   NSMutableArray  *mutableWorkers;
@property (nonatomic, assign)   NSInteger       workerCount;

@end

@implementation IDPRoom

@dynamic workers;

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    self.name = nil;
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString stringWithFormat:@"%@ #%lu",
                     [self class],
                     (unsigned long)IDPRandomTillNumber(kIDPSizeRandomNames)];
        self.mutableWorkers = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

- (NSInteger)workerCount {
    return self.workers.count;
}

#pragma mark -
#pragma mark Public Methods

- (void)changeWorkerCount:(NSInteger)count {
    self.workerCount += count;
}

- (void)addWorker:(IDPWorker *)worker {
    if (worker) {
        [self.mutableWorkers addObject:worker];
        [self changeWorkerCount:1];
    }
}

- (void)addWorkers:(NSArray *)workers {
    if (workers) {
        for (id worker in workers) {
            [self addWorker:worker];
        }
    }
}

- (void)removeWorker:(IDPWorker *)worker {
    [self.mutableWorkers removeObject:worker];
    [self changeWorkerCount:1];
}

- (void)removeWorkers:(NSArray *)workers {
    for (id worker in workers) {
        [self removeWorker:worker];
    }
}


@end
