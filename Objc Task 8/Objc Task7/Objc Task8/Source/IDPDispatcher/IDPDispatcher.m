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
@property (nonatomic, assign)   IDPQueue        *objectsQueue;
@property (nonatomic, assign)   IDPQueue        *handlersQueue;
@property (nonatomic, assign)   NSMutableArray  *handlersArray;

@end

@implementation IDPDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.objectsQueue = nil;
    self.handlersQueue = nil;
    self.handlersArray = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self.objectsQueue = [IDPQueue object];
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
        [object addObserver:self];
        [self.handlersQueue pushObject:object];
    }
}

- (void)removeHandler:(id)object {
    @synchronized (self) {
        [self.handlersArray removeObject:object];
        [object removeObserver:self];
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
            [self.objectsQueue pushObject:object];
        }
    }
}

#pragma mark -
#pragma mark IDPWorkerObserver Implementation

- (void)workerDidBecomeFree:(id)worker {
    @synchronized (self) {
        if ([self.handlersArray containsObject:worker]) {
            id object = [self.objectsQueue popObject];
            
            if (object) {
                [worker processObject:object];
            } else {
                [self.handlersQueue pushObject:worker];
            }
        }
    }
}

- (void)workerDidBecomeReadyForProcessing:(id)worker {
    @synchronized (self) {
        if (![self.handlersArray containsObject:worker]) {
            [self processObject:worker];
        }
    }
}

@end
