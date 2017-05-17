//
//  IDPManager.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPCarWashTest.h"
#import "IDPManager.h"
#import "IDPBuilding.h"
#import "IDPRoomWashCar.h"
#import "IDPCar.h"
#import "IDPAccountant.h"
#import "IDPWasher.h"
#import "IDPDirector.h"

#import "IDPRandom.h"
#import "IDPConstants.h"

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

@interface IDPManager ()
@property (nonatomic, retain)   NSMutableArray   *buildings;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Reallocations

- (void)dealloc {
    self.name = nil;
    self.buildings = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [NSString stringWithFormat:@"%@ #%lu",
                 [self class],
                 IDPRandomTillNumber(kIDPSizeRandomNames)];
    self.buildings = [NSMutableArray array];
    [self startProcess];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)startProcess {
    IDPBuilding *building = [IDPBuilding object];
    
    IDPWasher *washerNumberOne = [IDPWasher object];
    
    // car wash
    IDPRoomWashCar *carWashRoom = [IDPRoomWashCar object];
    [carWashRoom addWorker:washerNumberOne];
    
    // accountant & director
    IDPAccountant *accountantNumberOne = [IDPAccountant object];
    IDPDirector *directorNumberOne = [IDPDirector object];
    
    // office
    IDPRoom *roomOfficeNumberOne = [IDPRoom object];
    [roomOfficeNumberOne addWorkers:@[accountantNumberOne,directorNumberOne]];
    
    IDPBuilding *office = [IDPBuilding object];
    [office addRoom:roomOfficeNumberOne];
    
    [building addRoom:carWashRoom];
    [building addRoom:roomOfficeNumberOne];
    [self.buildings addObject:building];
}

- (void)washCar:(IDPCar *)car {
    IDPWasher *freeWasher = [self workersWithClass:[IDPWasher class]];
    IDPAccountant *firstAccountant = [self workersWithClass:[IDPAccountant class]];
    IDPDirector *firstDirector = [self workersWithClass:[IDPDirector class]];
    
    
    // 1. Мойщику мойки отдают машину
    // 2. Мойщик моет машину
    // 3. Мойщик забирает деньги у машины
    [freeWasher processObject:car];
    
    // 4. Мойщик отдает деньги бухгалтеру
    // 5. Бухгалтер считает деньги
    [firstAccountant processObject:freeWasher];
    
    // 6. Бухгалтер отдает деньги директору
    // 7. Директор получает прибыль
    [firstDirector processObject:firstAccountant];
}

- (id)freeWorkerWithArray:(NSArray *)workers {
    for (IDPWorker *worker in workers) {
        if (worker.state == IDPWorkerFree) {
            return worker;
        }
    }
    
    return nil;
}

- (id)workersWithClass:(Class)class {
    NSMutableArray *array = [NSMutableArray array];
    for (id building in self.buildings) {
        [array addObjectsFromArray:[building workersWithClass:class]];
    }
    
    return [self freeWorkerWithArray:array];
}

@end
