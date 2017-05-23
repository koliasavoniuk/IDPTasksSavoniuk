//
//  IDPRoomWashCar.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCarWashRoom.h"

@interface IDPCarWashRoom()
@property (nonatomic, retain)   NSMutableArray  *mutableCars;

@end

@implementation IDPCarWashRoom

@dynamic cars;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableCars = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addCar:(IDPCar *)car {
    if (car) {
        [self.mutableCars addObject:car];
    }
}

- (void)removeCar:(IDPCar *)car {
    [self.mutableCars removeObject:car];
}

@end