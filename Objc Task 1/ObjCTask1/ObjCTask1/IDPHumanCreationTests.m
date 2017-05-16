//
//  IDPHumanCreationTests.m
//  ObjCTask1
//
//  Created by Student002 on 5/4/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import"IDPHumanCreationTests.h"

#import "IDPHuman.h"

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
    NSArray *humanNames = @[@"Oleg", @"Igor", @"Vasya", @"Vova"];
    NSMutableArray *children = [NSMutableArray array];
    
    for (id name in humanNames) {
        [children addObject:[[[IDPHuman alloc] initWithName:name]autorelease]];
    }
    
    NSUInteger childCount[] = { 4, 2, 4, 6 };
    
    for (id tempObject in children) {
        id human = tempObject;
        for (NSUInteger i = 0; i < childCount[i]; i++) {
            [human giveBirth];
        }
    }
    
    for (id someObject in children) {
        [someObject sayHi];
        IDPHuman *human = someObject;
        
        if (human.gender == IDPHumanGenderMale) {
            [someObject fightHuman];
        } else {
            [someObject giveBirth];
        }
    }
}
