//
//  IDPHuman.m
//  ObjCTask1
//
//  Created by Student002 on 5/4/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPHuman.h"

#import "IDPRandom.h"

static const NSUInteger     kIDPAgeMax      = 100;
static const NSRange        kIDPWeightRange = { 1, 150 };

@interface IDPHuman ()
@property (nonatomic, assign)   IDPHumanGender  gender;
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, assign)   NSUInteger      age;
@property (nonatomic, assign)   NSUInteger      weight;
@property (nonatomic, retain)   NSMutableArray  *mutableChildren;

@end

@implementation IDPHuman

@dynamic children;

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    self.name = name;
    self.gender = IDPRandomBool();
    self.age = IDPRandomTillNumber(kIDPAgeMax);
    self.weight = IDPRandomWithRange(kIDPWeightRange);
    self.mutableChildren = [NSMutableArray array];
    
    return self;
}

- (NSArray *)children {
    return [[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)fight {
    NSLog(@"I wanna fight!!!");
}

- (void)giveBirth {
    NSLog(@"I make a child!!!");
}

- (void)sayHi {
    NSLog(@"%@Hi", self.name);
    NSMutableArray *children = self.mutableChildren;
    
    for (id child in children) {
        [child sayHi];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)addChildWithName:(NSString *)name {
    IDPHuman *baby = [[[IDPHuman alloc] initWithName:name] autorelease];
    [self.mutableChildren addObject:baby];
}

- (void)removeChild:(id)child {
    [self.mutableChildren removeObject:child];
}

@end
