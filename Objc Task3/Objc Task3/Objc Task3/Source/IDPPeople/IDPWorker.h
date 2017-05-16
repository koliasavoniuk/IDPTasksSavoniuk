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

typedef NS_ENUM (NSUInteger, IDPStateOfEmployment) {
    IDPBusy,
    IDPFree
};

@interface IDPWorker : IDPHuman <IDPCashFlow>
@property (nonatomic, readonly) NSUInteger experience;
@property (nonatomic, assign, readonly) NSUInteger salary;
@property (nonatomic, copy, readonly) NSString *responsibility;
@property (nonatomic, assign, readonly) IDPStateOfEmployment state;

- (NSUInteger) money;
- (void)processObject:(id)object;

@end
