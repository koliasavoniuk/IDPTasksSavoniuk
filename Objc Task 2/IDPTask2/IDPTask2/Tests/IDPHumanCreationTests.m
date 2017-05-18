//
//  IDPHumanCreationTests.m
//  IDPTask2
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import"IDPHumanCreationTests.h"

#import "IDPHuman.h"
#import "IDPMale.h"
#import "IDPFemale.h"

#import "IDPRandom.h"

#import "NSObject+IDPCategory.h"
#import "NSArray+IDPCategory.h"

static const char objectCount = 7;

typedef id(^IDPObject)();

#pragma mark -
#pragma mark Private Declaration

static
void IDPObjCHumanCreationTesting();

#pragma mark -
#pragma mark Public Implementation

void IDPObjCHumanCreationTests() {
    IDPObjCHumanCreationTesting();
}

#pragma mark -
#pragma mark Private Implementation

void IDPObjCHumanCreationTesting() {
    IDPObject generator = ^{
        return IDPRandomBool() ? [IDPMale object] : [IDPFemale object];
    };
    
    NSArray *humans = [NSArray objectsWithCount:objectCount factoryBlock:generator];
    
    for (IDPHuman *human in humans) {
        [human performGenderSpecificOperation];
    }
}
