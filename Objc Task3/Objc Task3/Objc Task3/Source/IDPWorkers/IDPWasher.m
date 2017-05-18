//
//  IDPWasher.m
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPWasher.h"

@interface IDPWasher ()
@property (nonatomic, retain)   IDPCar  *car;

@end

@implementation IDPWasher

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(id)object {
    [self washCar:object];
}

- (void)washCar:(IDPCar *)car {
    if (!car) {
        NSLog(@"%@ - can't wash car, because car not found", self.name);
        return;
    }
    
    self.car = car;
    NSLog(@"Car: %@ washed", self.car.name);
    self.car = nil;
    car.state = IDPCarClean;
}   

@end
