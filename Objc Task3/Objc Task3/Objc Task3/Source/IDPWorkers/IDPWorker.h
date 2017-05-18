//
//  IDPWorker.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPHuman.h"
#import "IDPRandom.h"
#import "IDPCashFlow.h"

typedef NS_ENUM (NSUInteger, IDPWorkerState) {
    IDPWorkerBusy,
    IDPWorkerFree
};

@interface IDPWorker : IDPHuman <IDPCashFlow>
@property (nonatomic, readonly)         NSUInteger          experience;
@property (nonatomic, readonly)         NSUInteger          salary;
@property (nonatomic, readonly)         IDPWorkerState      state;

- (void)processObject:(id<IDPCashFlow>)object;

// This method is created for subclasses, don't call this method manually
- (void)performWorkWithObject:(id<IDPCashFlow>)object;

@end
