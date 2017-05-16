//
//  IDPRoomWashCar.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPRoomWashCar.h"

@interface IDPRoomWashCar()
@property (nonatomic, retain)   NSMutableArray  *mutableCars;

@end

@implementation IDPRoomWashCar

@dynamic cars;

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

@end
