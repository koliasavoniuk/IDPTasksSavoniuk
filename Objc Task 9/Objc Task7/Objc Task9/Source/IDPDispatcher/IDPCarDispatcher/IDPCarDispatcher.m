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
#import "IDPGCDWrapper.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"
#import "NSTimer+IDPExtensions.h"

//static NSString * const kIDPGCDQueue      = @"kIDPGCDQueue";

@interface IDPCarDispatcher ()
@property (nonatomic, retain) NSTimer           *timer;
@property (nonatomic, retain) IDPManager        *manager;
@property (nonatomic, retain) dispatch_queue_t  queue;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    
    self.timer = nil;
    self.manager = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.manager = [IDPManager object];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setTimer:(NSTimer *)timer {
    if (NO == timer) {
        return;
    }
    
    if (timer != _timer) {
        [_timer invalidate];
        [timer release];
        _timer = [timer retain];
    }
}

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    _running = running;
    
    if (running) {
        [self start];
    } else {
        [self stop];
    }
    
}

#pragma mark -
#pragma mark Private Methods

- (void)start {
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self addCarsInBackground];

        if (self.running) {
            [self start];
        }
    });
    
}

- (void)stop {
    self.running = NO;
}

#pragma mark -
#pragma mark Public

- (void)addCarsInBackground {
    IDPDispatchSyncOnMainQueue(^{
        NSArray *cars =  [IDPCar objectsWithCount:kIDPCarsCount];
        [self.manager processCars:cars];
    });
}

@end

