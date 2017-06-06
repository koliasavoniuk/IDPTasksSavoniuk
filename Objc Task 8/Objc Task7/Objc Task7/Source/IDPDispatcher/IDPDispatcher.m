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
@property (nonatomic, assign)    IDPQueue        *objects;
@property (nonatomic, assign)    NSMutableArray  *handlers;
@end

@implementation IDPDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.objects = nil;
    self.handlers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self.objects = [IDPQueue object];
    self.handlers = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addHandler:(id<IDPWorkerObserver>)object {
    if (!object) {
        return;
    }
    @synchronized (self) {
        [self.handlers addObject:object];
    }
}

- (void)deleteHandler:(id<IDPWorkerObserver>)object {
    @synchronized (self) {
        [self.handlers removeObject:object];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)processObject:(id)object {
    NSMutableArray *handlerArray = self.handlers;
    IDPWorker *handler = handlerArray.firstObject;
    
    if (handler) {
        [handler processObject:object];
        [self deleteHandler:handler];
    } else {
        [self.objects pushObject:object];
    }
}

#pragma mark -
#pragma mark IDPWorkerObserver Implementation

- (void)workerDidBecomeFree:(id)worker {
    id object = [self.objects popObject];
    
    if (object) {
        [worker processObject:object];
    } else {
        [self.handlers addObject:worker];
    }
}

@end
