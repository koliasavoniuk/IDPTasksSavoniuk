//
//  IDPCarWashTest.m
//  Objc Task3
//
//  Created by Student002 on 5/12/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCarWashTest.h"

#import "IDPManager.h"
#import "IDPCar.h"

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

#pragma mark -
#pragma mark Private Declaration

static
void IDPCarWashTestOne();

#pragma mark -
#pragma mark Public Implementations

void IDPCarWashTest() {
    IDPCarWashTestOne();
}

#pragma mark -
#pragma mark PrivateDeclaretions

void IDPCarWashTestOne() {
    NSArray *cars = [IDPCar objectsWithCount:kIDPCarsCount];
    
    IDPManager *manager = [IDPManager object];
    
    
    for (IDPCar *car in cars) {
        [manager washCar:car];
    }
}
