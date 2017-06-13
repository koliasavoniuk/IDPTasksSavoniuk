//
//  IDPObservableObject.m
//  Objc Task7
//
//  Created by Student002 on 5/29/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPObservableObject.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPObservableObject ()
@property (nonatomic, retain) NSHashTable *mutableObservers;

@end

@implementation IDPObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableObservers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    return [[self.mutableObservers copy] autorelease];
}

- (void)setState:(NSUInteger)state {
    _state = state;
    
    [self notifyOfState:state];
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id)observer {
    if (observer) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)deleteObserver:(id)observer {
    [self.mutableObservers removeObject:observer];
}

// should be overriden in subclasses
- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyOfState:(NSUInteger)state {
    [self notifyOfStateWithSelector:[self selectorForState:state]];
}

#pragma mark -
#pragma mark Private

- (void)notifyOfStateWithSelector:(SEL)selector {
    NSSet *observers = self.observers;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self];
        }
    }
}

@end
