//
//  IDPCarWashTest.m
//  Objc Task3
//
//  Created by Student002 on 5/12/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCarWashTest.h"
#import "IDPManager.h"
#import "IDPBuilding.h"
#import "IDPRoomWashCar.h"
#import "IDPCar.h"
#import "IDPAccountant.h"
#import "IDPWasher.h"
#import "IDPDirector.h"

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

static const NSInteger kIDPCountCars = 5;

#pragma mark -
#pragma mar Private Declaration

static
void IDPCarWashTestOne();

#pragma mark -
#pragma mar Public Implementations

void IDPCarWashTest() {
    IDPCarWashTestOne();
}

#pragma mark -
#pragma mar PrivateDeclaretions

void IDPCarWashTestOne() {
    NSArray *cars = [IDPCar objectsWithCount:kIDPCountCars];
    
    IDPManager *manager = [IDPManager object];
    
    
    for (IDPCar *car in cars) {
        [manager washCar:car];
    }
}
