//
//  IDPBuilding.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPBuilding.h"
#import "IDPConstants.h"
#import "IDPRandom.h"

#import "NSArray+IDPCategory.h"

@class IDPRoomWashCar;
@class IDPRoom;

@interface IDPBuilding()
@property (nonatomic, retain)   NSMutableArray  *mutableRooms;
@property (nonatomic, assign)   NSInteger       countHumens;

@end

@implementation IDPBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    self.name = nil;
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString stringWithFormat:@"%@ #%lu",
                     [self class],
                     IDPRandomTillNumber(kIDPSizeRandomNames)];
        self.mutableRooms = [NSMutableArray array];
        self.countHumens = 0;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

-(NSMutableArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addRoom:(IDPRoom *)room {
    if (room) {
        [self.mutableRooms addObject:room];
    }
}

- (void)removeRoom:(IDPRoom *)room {
    [self.mutableCopy removeObject:room];
}

- (NSArray *)workersWithClass:(Class)class {
    
    NSMutableArray *array = [NSMutableArray array];
    for (id room in self.mutableRooms ) {
        NSArray *workers =  [[room workers] arrayByFilteringWithBlock:^BOOL(id object) {
            return [object isKindOfClass:[class class]];
        }];
        [array addObjectsFromArray:workers];
    }
    
    return array;
}

@end

