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
#import "IDPCarDispatcher.h"

#import "NSArray+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

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
#pragma mark Private Declarations

void IDPCarWashTestOne() {
    IDPCarDispatcher *dispatcher = [IDPCarDispatcher object];
    dispatcher.running = YES;
}
