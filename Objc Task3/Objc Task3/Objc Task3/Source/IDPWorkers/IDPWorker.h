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

typedef NS_ENUM (NSUInteger, IDPStateOfWorker) {
    IDPWorkerBusy,
    IDPWorkerFree
};

@interface IDPWorker : IDPHuman <IDPCashFlow>
@property (nonatomic, readonly)         NSUInteger          experience;
@property (nonatomic, readonly)         NSUInteger          salary;
@property (nonatomic, copy, readonly)   NSString            *responsibility;
@property (nonatomic, readonly)         IDPStateOfWorker    state;

- (void)processObject:(id<IDPCashFlow>)object;
- (void)performWorkWithObject:(id<IDPCashFlow>)object;

@end
