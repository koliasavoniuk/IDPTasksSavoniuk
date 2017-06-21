//
//  IDPDispatcher.m
//  Objc Task7
//
//  Created by Student002 on 6/6/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPDispatcher.h"

#import "IDPQueue.h"
#import "NSObject+IDPExtensions.h"
#import "IDPWorker.h"

@interface IDPDispatcher()
@property (nonatomic, assign)   IDPQueue        *objects;
@property (nonatomic, assign)   IDPQueue        *handlersQueue;
@property (nonatomic, assign)   NSMutableArray  *handlersArray;

@end

@implementation IDPDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.objects = nil;
    self.handlersQueue = nil;
    self.handlersArray = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self.objects = [IDPQueue object];
    self.handlersQueue = [IDPQueue object];
    self.handlersArray = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addHandler:(id)object {
    if (!object) {
        return;
    }
    @synchronized (self) {
        [self.handlersArray addObject:object];
        [self.handlersQueue pushObject:object];
        [object addObserver:self];
    }
}

- (void)removeHandler:(id)object {
    @synchronized (self) {
        [object removeObserver:self];
        [self.handlersArray removeObject:object];
    }
}

- (void)addHandlers:(NSArray *)handlers {
    for (id handler in handlers) {
        [self addHandler:handler];
    }
}

- (void)removeHandlers:(NSArray *)handlers {
    for (id handler in handlers) {
        [self removeHandler:handler];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)processObject:(id)object {
    @synchronized (self) {
        IDPWorker *handler = [self.handlersQueue popObject];
        
        if (handler) {
            [handler processObject:object];
        } else {
            [self.objects pushObject:object];
        }
    }
}

#pragma mark -
#pragma mark IDPWorkerObserver Implementation

- (void)workerDidBecomeFree:(id)worker {
    if ([self.handlersArray containsObject:worker]) {
        id object = [self.objects popObject];
        
        if (object) {
            [worker processObject:object];
        } else {
            [self.handlersQueue pushObject:worker];
        }
    }
}

- (void)workerDidBecomeReadyForProcessing:(id)worker {
    if (![self.handlersArray containsObject:worker]) {
        [self processObject:worker];
    }
}

@end
