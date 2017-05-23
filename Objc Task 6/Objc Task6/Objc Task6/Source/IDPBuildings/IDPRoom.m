//
//  IDPRoom.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPRoom.h"

#import "IDPRandom.h"
#import "IDPConstants.h"

#import "NSArray+IDPCategory.h"

@interface IDPRoom ()
@property (nonatomic, retain)   NSMutableArray  *mutableWorkers;

@end

@implementation IDPRoom

@dynamic workers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addWorker:(IDPWorker *)worker {
    if (worker) {
        [self.mutableWorkers addObject:worker];
    }
}

- (void)addWorkers:(NSArray *)workers {
    for (id worker in workers) {
        [self addWorker:worker];
    }

}

- (void)removeWorker:(IDPWorker *)worker {
    [self.mutableWorkers removeObject:worker];
}

- (void)removeWorkers:(NSArray *)workers {
    for (id worker in workers) {
        [self removeWorker:worker];
    }
}

- (NSArray *)workersWithClass:(Class)class {
    return [[self workers] arrayByFilteringWithBlock:^BOOL(id object) {
        return [object isKindOfClass:class];
    }];
}

@end