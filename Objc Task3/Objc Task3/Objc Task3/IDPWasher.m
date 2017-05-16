//
//  IDPWasher.m
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPWasher.h"

static const NSRange kIDPRangeSalary = { 500, 5000 };

@interface IDPWasher ()
@property (nonatomic, retain) IDPCar *car;
@property (nonatomic, assign, readwrite) NSInteger salary;

@end

@implementation IDPWasher

@dynamic salary;

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    [_car release];
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.salary = IDPRandomWithRange(kIDPRangeSalary);
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(id)object {
    [self washCar:object];
}

- (void)washCar:(IDPCar *)car {
    if (!car) {
        NSLog(@"%@ - can't washing car, because car not found",self.name);
        return;
    }
    self.car = car;
    NSLog(@"Car: %@ washed", self.car.name);
    self.car = nil;
    car.state = IDPCarClean;

    }   

@end
