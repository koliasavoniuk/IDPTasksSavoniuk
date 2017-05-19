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
@property (nonatomic, readonly)   NSArray     *workers;

- (void)addWorker:(IDPWorker *)worker;
- (void)removeWorker:(IDPWorker *)worker;

- (void)addWorkers:(NSArray *)workers;
- (void)removeWorkers:(NSArray *)workers;

- (NSArray *)workersWithClass:(Class)cls;

@end
