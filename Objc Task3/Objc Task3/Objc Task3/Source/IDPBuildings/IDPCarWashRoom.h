//
//  IDPRoomWashCar.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPRoom.h"

@class IDPCar;

@interface IDPRoomWashCar : IDPRoom
@property (nonatomic, readonly)   NSArray  *cars;

- (void)addCar:(IDPCar *)car;
- (void)removeCar:(IDPCar *)car;

@end
