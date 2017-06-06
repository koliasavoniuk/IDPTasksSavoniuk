//
//  IDPCarDispatcher.m
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCarDispatcher.h"

#import "IDPManager.h"
#import "IDPCar.h"
#import "IDPQueue.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"
#import "NSTimer+IDPExtensions.h"

@interface IDPCarDispatcher ()
@property (nonatomic, retain) NSTimer       *timer;
@property (nonatomic, retain) IDPManager    *manager;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    
    self.timer = nil;
    self.manager = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.manager = [IDPManager object];
    self.timer = [[NSTimer new] autorelease];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setTimer:(NSTimer *)timer {
    [_timer invalidate];
    [timer release];
    _timer = [timer retain];
}

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    if (running) {
        [self start];
    } else {
        [self stop];
    }
}

#pragma mark -
#pragma mark Public

- (void)start {
    self.timer = [NSTimer scheduledWeakReferenceTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(addCars)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)stop {
    self.timer = nil;
}

- (void)addCars {
    [self.manager processCars:[IDPCar objectsWithCount:kIDPCarsCount]];
}

@end

