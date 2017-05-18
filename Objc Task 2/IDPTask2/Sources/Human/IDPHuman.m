//
//  IDPHuman.m
//  IDPTask2
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPHuman.h"
#import "IDPRandom.h"

#import "NSObject+IDPCategory.h"

static const char kIDPAgeMax = 100;
static const NSRange kIDPWeightRange = { 1, 150 };
static const NSUInteger kIDPRandomNameSize = 700;

@interface IDPHuman ()
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

- (instancetype)init {
    self = [super init];
    self.name = [NSString stringWithFormat:@"Human #%lu", (unsigned long)IDPRandomTillNumber(kIDPRandomNameSize)];
    self.age = IDPRandomTillNumber(kIDPAgeMax);
    self.weight = IDPRandomWithRange(kIDPWeightRange);
    self.mutableChildren = [NSMutableArray array];
    
    return self;
}

- (NSArray *)children {
    return[[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)sayHi {
    NSLog(@"%@Hi", self.name);

    for (id child in self.mutableChildren) {
        [child sayHi];
    }
}

- (void)performGenderSpecificOperation {
    
}

#pragma mark -
#pragma mark Private Methods

- (void)addChild:(IDPHuman *)child {
    if (child) {
        [self.mutableChildren addObject:child];
    }
}

- (void)removeChild:(IDPHuman *)child {
    [self.mutableChildren removeObject:child];
}

@end
