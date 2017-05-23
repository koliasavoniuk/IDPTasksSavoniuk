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

@class IDPCarWashRoom;
@class IDPRoom;

@interface IDPBuilding()
@property (nonatomic, retain)   NSMutableArray  *mutableRooms;

@end

@implementation IDPBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSMutableArray *)rooms {
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
    [self.mutableRooms removeObject:room];
}

- (NSArray *)workersWithClass:(Class)class {    
    NSMutableArray *array = [NSMutableArray array];
    for (id room in self.mutableRooms) {
        [array addObjectsFromArray:[room workersWithClass:class]];
    }
    
    return array;
}

@end