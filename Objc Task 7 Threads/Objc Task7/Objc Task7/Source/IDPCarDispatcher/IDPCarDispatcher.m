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

//#import "IDPMacros.h"

#import "NSObject+IDPExtension.h"
#import "NSArray+IDPCategory.h"
#import "NSTimer+IDPExtensions.h"

//IDPStaticConstant(NSUInteger, IDPCarsQuantity, 10)
static const NSUInteger IDPCarsQuantity = 10;

@interface IDPCarDispatcher ()
@property (nonatomic, assign) NSTimer       *timer;
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
    _timer = timer;
}

#pragma mark -
#pragma mark Public

- (void)setTimerUp {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                  target:self
                                                selector:@selector(addCars)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)addCars {
    [self.manager washCar:[IDPCar objectsWithCount:IDPCarsQuantity]];
}

@end

