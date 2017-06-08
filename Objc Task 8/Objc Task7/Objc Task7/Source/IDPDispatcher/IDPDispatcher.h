//
//  IDPDispatcher.h
//  Objc Task7
//
//  Created by Student002 on 6/6/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPWorkerObserver.h"

@interface IDPDispatcher : NSObject<IDPWorkerObserver>

- (void)processObject:(id)object;

- (void)addHandler:(id<IDPWorkerObserver>)object;
- (void)deleteHandler:(id<IDPWorkerObserver>)object;

- (void)addHandlers:(NSArray *)handlers;
- (void)deleteHandlers:(NSArray *)handlers;

@end
