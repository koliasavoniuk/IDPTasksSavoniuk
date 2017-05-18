//
//  IDPManager.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPManager.h"

//#import "IDPCarWashTest.h"
#import "IDPBuilding.h"
#import "IDPCarWashRoom.h"
//#import "IDPCar.h"
#import "IDPAccountant.h"
#import "IDPWasher.h"
#import "IDPDirector.h"

//#import "IDPRandom.h"
//#import "IDPConstants.h"

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

@interface IDPManager ()
@property (nonatomic, retain)   NSMutableArray   *buildings;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    //self.name = nil;
    self.buildings = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    //self.name = [NSString stringWithFormat:@"%@ #%lu",
    //             [self class],
    //             IDPRandomTillNumber(kIDPSizeRandomNames)];
    self.buildings = [NSMutableArray array];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    IDPBuilding *building = [IDPBuilding object];
    IDPWasher *washer = [IDPWasher object];
    
    // car wash
    IDPRoomWashCar *carWashRoom = [IDPRoomWashCar object];
    [carWashRoom addWorker:washer];
    
    // accountant & director
    IDPAccountant *accountant = [IDPAccountant object];
    IDPDirector *director = [IDPDirector object];
    
    // office
    IDPRoom *officeRoom = [IDPRoom object];
    [officeRoom addWorkers:@[accountant,director]];
    
    IDPBuilding *office = [IDPBuilding object];
    [office addRoom:officeRoom];
    [building addRoom:carWashRoom];
    [building addRoom:officeRoom];
    [self.buildings addObject:building];
}

- (void)washCar:(IDPCar *)car {
    IDPWasher *freeWasher = [self freeWorkerWithClass:[IDPWasher class]];
    IDPAccountant *freeAccountant = [self freeWorkerWithClass:[IDPAccountant class]];
    IDPDirector *freeDirector = [self freeWorkerWithClass:[IDPDirector class]];
    
    // 1. Мойщику мойки отдают машину
    // 2. Мойщик моет машину
    // 3. Мойщик забирает деньги у машины
    [freeWasher processObject:car];
    
    // 4. Мойщик отдает деньги бухгалтеру
    // 5. Бухгалтер считает деньги
    [freeAccountant processObject:freeWasher];
    
    // 6. Бухгалтер отдает деньги директору
    // 7. Директор получает прибыль
    [freeDirector processObject:freeAccountant];
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
        return worker.state == IDPWorkerFree;
    }];
}

- (id)freeWorkerWithClass:(Class)class {
    return [[self freeWorkersWithClass:class]firstObject];
}

@end
