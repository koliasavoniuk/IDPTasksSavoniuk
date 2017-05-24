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

#import "IDPWorkerDelegate.h"

typedef NS_ENUM (NSUInteger, IDPWorkerState) {
    IDPWorkerBusy,
    IDPWorkerReadyToProcess,
    IDPWorkerFree
};

@interface IDPWorker : NSObject<IDPCashFlow, IDPWorkerDelegate>
@property (nonatomic, copy)         NSString                *name;
@property (nonatomic, readonly)     NSUInteger              experience;
@property (nonatomic, readonly)     IDPWorkerState          state;

@property (nonatomic, assign)       id<IDPWorkerDelegate>   delegate;

- (void)processObject:(id<IDPCashFlow>)object;

// This method is created for subclasses, don't call this method manually
- (void)performWorkWithObject:(id<IDPCashFlow>)object;

@end
