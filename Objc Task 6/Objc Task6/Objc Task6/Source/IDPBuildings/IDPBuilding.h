//
//  IDPBuilding.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPRoom.h"

@interface IDPBuilding : NSObject
@property (nonatomic, readonly) NSArray  *rooms;

- (void)addRoom:(IDPRoom *)room;
- (void)removeRoom:(IDPRoom *)room;

- (NSArray *)workersWithClass:(Class)cls;

@end