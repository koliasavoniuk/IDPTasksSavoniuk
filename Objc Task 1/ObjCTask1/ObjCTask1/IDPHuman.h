//
//  IDPHuman.h
//  ObjCTask1
//
//  Created by Student002 on 5/4/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, IDPHumanGender) {
    IDPHumanGenderMale,
    IDPHumanGenderFemale
};

@interface IDPHuman : NSObject
@property (nonatomic, readonly)          IDPHumanGender  gender;
@property (nonatomic, readonly)          NSString        *name;
@property (nonatomic, readonly)          NSUInteger      age;
@property (nonatomic, readonly)          NSUInteger      weight;
@property (nonatomic, copy, readonly)    NSArray         *children;

- (instancetype)initWithName:(NSString *)name;

- (void)fight;
- (void)giveBirth;
- (void)sayHi;

- (void)addChildWithName:(NSString *)name;
- (void)removeChild:(IDPHuman *)child;

@end
