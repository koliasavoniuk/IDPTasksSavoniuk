//
//  IDPHuman.h
//  IDPTask2
//
//  Created by Student002 on 5/10/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPHuman : NSObject
@property (nonatomic, readonly)          NSString        *name;
@property (nonatomic, readonly)          NSUInteger      age;
@property (nonatomic, readonly)          NSUInteger      weight;
@property (nonatomic, copy, readonly)    NSArray         *children;

- (void)sayHi;

- (void)addChild:(IDPHuman *)child;
- (void)removeChild:(IDPHuman *)child;

- (void)performGenderSpecificOperation;

@end
