//
//  IDPManager.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPCar;
@class IDPWasher;
@class IDPWorker;
@class IDPAccountant;
@class IDPDirector;

@interface IDPManager : NSObject
@property (nonatomic, copy)     NSString      *name;

- (void)createWorld;
- (void)washCar:(IDPCar *)car;

- (id)freeWorkerWithClass:(Class)classs;

@end

