//
//  IDPQueue.m
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPQueue.h"

@interface IDPQueue ()
@property (nonatomic,retain)  NSMutableArray    *queue;

@end

@implementation IDPQueue

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.queue = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)pushObject:(id)object {
    if (!object) {
        return;
    }
    
    @synchronized (self) {
        [self.queue addObject:object];
    }
}

- (id)popObject {
    @synchronized (self) {
        NSMutableArray *queue = self.queue;
        id object = [[queue.firstObject retain]autorelease];
        [queue removeObject:object];
        
        return object;
    }
}

- (BOOL)isEmpty {
    @synchronized (self) {
        return !self.queue.count;
    }
}

@end