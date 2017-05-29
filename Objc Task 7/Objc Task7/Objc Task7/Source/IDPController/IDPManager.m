//
//  IDPManager.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPManager.h"

#import "IDPAccountant.h"
#import "IDPWasher.h"
#import "IDPDirector.h"
#import "IDPConstants.h"

#import "NSArray+IDPCategory.h"
#import "NSObject+IDPExtension.h"

@interface IDPManager ()
@property (nonatomic, retain) NSMutableArray           *washers;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.washers = nil;
    self.accountant = nil;
    self.director = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washers = [NSMutableArray array];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSMutableArray *)washers {
    if (_washers) {
        for (IDPWasher *washer in _washers) {
            [washer deleteObserver:self.accountant];
        }
    }
    
    _washers = washers;
}

#pragma mark -
#pragma mark Public Methods

- (void)buildCarWash {
    
    NSArray *washers = [IDPWasher objectsWithCount:IDPRandomTillNumber(kIDPSizeRandomWashers)];
    self.washers = [[washers copy] autorelease];
    IDPAccountant *accountant = [IDPAccountant object];
    IDPDirector *director = [IDPDirector object];
    
    for (IDPWasher *washer in washers) {
        [washer addObserver:accountant];
    }
    
    [accountant addObserver:director];
}

- (void)washCar:(IDPCar *)car {
    IDPWasher *washer = [self freeWasher];
    
    [washer processObject:car];
}

 - (id)freeWasher {
     NSArray *washers = [self.washers arrayByFilteringWithBlock:^BOOL(IDPWasher *washer) {
         return washer.state == IDPWorkerFree;
     }];
     
     return [washers firstObject];
 }

@end
