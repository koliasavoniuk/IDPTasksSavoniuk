//
//  IDPRoom.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPWorker.h"

@interface IDPRoom : NSObject

@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, retain)   NSArray     *workers;
@property (nonatomic, readonly) NSInteger   workerCount;

- (void)addWorker:(IDPWorker *)worker;
- (void)addWorkers:(NSArray *)workers;
- (void)removeWorker:(IDPWorker *)worker;
- (void)removeWorkers:(NSArray *)workers;

@end
