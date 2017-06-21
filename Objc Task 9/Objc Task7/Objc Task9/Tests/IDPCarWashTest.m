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

    double delayInSeconds = 10.0;
    __block IDPCarDispatcher *weekDispatcher = dispatcher;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"------------- STOP");
        weekDispatcher.running = NO;
        
    });
}
