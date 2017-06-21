//
//  IDPManager.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPManager.h"

#import "IDPBuilding.h"
#import "IDPCarWashRoom.h"
#import "IDPAccountant.h"
#import "IDPWasher.h"
#import "IDPDirector.h"

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

@interface IDPManager ()
@property (nonatomic, retain)   NSMutableArray   *buildings;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.buildings = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.buildings = [NSMutableArray array];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    IDPBuilding *officeBuilding = [IDPBuilding object];
    IDPBuilding *carWashBuilding = [IDPBuilding object];
    
    IDPWasher *washer = [IDPWasher object];
    IDPAccountant *accountant = [IDPAccountant object];
    IDPDirector *director = [IDPDirector object];
    
    IDPCarWashRoom *carWashRoom = [IDPCarWashRoom object];
    [carWashRoom addWorker:washer];
    
    IDPRoom *officeRoom = [IDPRoom object];
    [officeRoom addWorkers:@[accountant, director]];
    
    [carWashBuilding addRoom:carWashRoom];
    [officeBuilding addRoom:officeRoom];

    [self.buildings addObjectsFromArray:@[carWashRoom, officeRoom]];
}

- (void)washCar:(IDPCar *)car {
    IDPWasher *washer = [self freeWorkerWithClass:[IDPWasher class]];
    IDPAccountant *accountant = [self freeWorkerWithClass:[IDPAccountant class]];
    IDPDirector *director = [self freeWorkerWithClass:[IDPDirector class]];
    
    // 1. Мойщику мойки отдают машину
    // 2. Мойщик моет машину
    // 3. Мойщик забирает деньги у машины
    [washer processObject:car];
    
    // 4. Мойщик отдает деньги бухгалтеру
    // 5. Бухгалтер считает деньги
    [accountant processObject:washer];
    
    // 6. Бухгалтер отдает деньги директору
    // 7. Директор получает прибыль
    [director processObject:accountant];
}

- (id)workersWithClass:(Class)class {
    NSMutableArray *array = [NSMutableArray array];
    
    for (IDPBuilding *building in self.buildings) {
        [array addObjectsFromArray:[building workersWithClass:class]];
    }
    
    return [[array copy] autorelease];
}

- (id)freeWorkersWithClass:(Class)class {
    return [[self workersWithClass:class] arrayByFilteringWithBlock:^BOOL(IDPWorker *worker) {
        return IDPWorkerFree == worker.state;
    }];
}

- (id)freeWorkerWithClass:(Class)class {
    return [[self freeWorkersWithClass:class] firstObject];
}

@end
