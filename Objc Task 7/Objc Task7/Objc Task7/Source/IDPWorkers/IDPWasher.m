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
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(IDPCar *)object {
    [self washCar:object];
}

- (void)washCar:(IDPCar *)car {
    self.car = car;
    NSLog(@"Car: %@ washed, washer %@", self.car.name, self.name);
    self.car = nil;
}   

- (void)finishProcessingObject:(IDPCar *)car {
    car.state = IDPCarClean;
}

@end
