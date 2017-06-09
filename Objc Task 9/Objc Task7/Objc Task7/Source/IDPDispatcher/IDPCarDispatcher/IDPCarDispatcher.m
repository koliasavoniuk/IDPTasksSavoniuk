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
#import "IDPGCDWrap.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"
#import "NSTimer+IDPExtensions.h"

static NSString * const kIDPGCDQueue      = @"kIDPGCDQueue";

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
    if (running != _running) {
        if (YES == running) {
            dispatch_queue_t queue = dispatch_queue_create([kIDPGCDQueue cStringUsingEncoding:NSUTF8StringEncoding],
                                                           DISPATCH_QUEUE_CONCURRENT);
            self.queue = queue;
            dispatch_release(queue);
            
            dispatch_apply(kIDPIterationCount, queue, ^(size_t count) {
                [self addCarsInBackground];
            });
        } else {
            self.queue = nil;
        }
        
        _running = running;
    }
    
}

#pragma mark -
#pragma mark Public

- (void)addCarsInBackground {
    IDPExecuteConcurrentInBackgroundWithBlock(^{
        [self.manager processCars:[IDPCar objectsWithCount:kIDPCarsCount]];
    });
}

@end

