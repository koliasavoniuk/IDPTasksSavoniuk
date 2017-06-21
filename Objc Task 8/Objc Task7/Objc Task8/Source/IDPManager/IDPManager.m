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
#import "IDPQueue.h"
#import "IDPWorkerObserver.h"
#import "IDPDispatcher.h"

#import "NSArray+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

@interface IDPManager ()
@property (nonatomic, retain) IDPDispatcher     *washersDispatcher;
@property (nonatomic, retain) IDPDispatcher     *accountantsDispatcher;
@property (nonatomic, retain) IDPDispatcher     *directorDispatcher;

@end

@implementation IDPManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    [self buildCarWash];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processCars:(NSArray *)cars {
    for (IDPCar *car in cars) {
        [self processCar:car];
    }
}

- (void)processCar:(IDPCar *)car {
    @synchronized (self) {
        if (car) {
            [self.washersDispatcher processObject:car];
        }
    }
}

#pragma mark -
#pragma mark Private

typedef id(^IDPDispatcherFactory)(Class handlerClass, NSUInteger handlerCount, id observer);

- (void)buildCarWash {
    IDPDispatcherFactory factory = ^id(Class handlerClass, NSUInteger handlerCount, id observer) {
        id dispatcher = [IDPDispatcher object];
        
        id handlers = [NSArray objectsWithCount:handlerCount factoryBlock:^{
            id handler = [handlerClass object];
            [handler addObserver:observer];
            
            return handler;
        }];
        
        [dispatcher addHandlers:handlers];
        
        return dispatcher;
    };
    
    IDPDispatcher *directorDispatcher = factory([IDPDirector class], kIDPDirectorCount, nil);
    IDPDispatcher *accountantsDispatcher = factory([IDPAccountant class], kIDPAccountantCount, directorDispatcher);
    IDPDispatcher *washersDispatcher = factory([IDPWasher class],kIDPWashersCount, accountantsDispatcher);
    
    self.washersDispatcher = washersDispatcher;
    self.accountantsDispatcher = accountantsDispatcher;
    self.directorDispatcher = directorDispatcher;
}

@end
