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
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setTimer:(NSTimer *)timer {
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
    
    if (running) {
        self.timer = [NSTimer scheduledWeakReferenceTimerWithTimeInterval:kIDPTimeInterval
                                                                   target:self
                                                                 selector:@selector(addCars)
                                                                 userInfo:nil
                                                                  repeats:NO];
    } else {
        [self.timer invalidate];
    }
}

#pragma mark -
#pragma mark Public

- (void)addCars {
    [self.manager processCars:[IDPCar objectsWithCount:kIDPCarsCount]];
}

@end

