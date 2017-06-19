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

@interface IDPCarDispatcher ()
@property (nonatomic, retain) IDPManager        *manager;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
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

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    _running = running;
    
    if (running) {
        IDPDispatchAsyncInBackgroundWithInterval(kIDPTimerInterval,
                                                 ^{ [self addCars]; },
                                                 ^BOOL(){ return self.running; });
    }
}

#pragma mark -
#pragma mark Public

- (void)addCars {
        NSArray *cars =  [IDPCar objectsWithCount:kIDPCarsCount];
        [self.manager processCars:cars];
}

@end

