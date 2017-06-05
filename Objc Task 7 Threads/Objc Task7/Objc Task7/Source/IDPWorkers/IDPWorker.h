//
//  IDPWorker.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPConstants.h"
#import "IDPRandom.h"

#import "IDPCashFlow.h"
#import "IDPObservableObject.h"
#import "IDPWorkerObserver.h"

typedef NS_ENUM (NSUInteger, IDPWorkerState) {
    IDPWorkerBusy,
    IDPWorkerReadyForProcessing,
    IDPWorkerFree
};

@interface IDPWorker : IDPObservableObject<IDPCashFlow, IDPWorkerObserver>
@property (nonatomic, copy)         NSString                *name;
@property (nonatomic, readonly)     NSUInteger              experience;
@property (nonatomic, readonly)     NSUInteger              money;

- (void)processObject:(id<IDPCashFlow>)object;

// This method is intended for subclassing. Never call it directly
- (void)performWorkWithObject:(id<IDPCashFlow>)object;

@end
