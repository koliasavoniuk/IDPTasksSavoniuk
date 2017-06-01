//
//  IDPCar.h
//  Objc Task3
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPConstants.h"
#import "IDPRandom.h"

#import "IDPCashFlow.h"

typedef NS_ENUM(NSUInteger, IDPCarState) {
    IDPCarClean,
    IDPCarDirty
};

@interface IDPCar : NSObject <IDPCashFlow>
@property(nonatomic, copy)   NSString    *name;
@property(nonatomic, assign) IDPCarState state;

@end
