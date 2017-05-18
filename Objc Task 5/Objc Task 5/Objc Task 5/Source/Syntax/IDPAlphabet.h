//
//  IDPAlphabet.h
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//


#import <Foundation/Foundation.h>

//extern
//NSRange IDPMakeAlphabetRange)(unichar value1, unichar value2);

@interface IDPAlphabet : NSArray

+ (instancetype)alphabetWithRange:(NSRange)range;
+ (instancetype)alphabetWithStrings:(NSArray *)strings;
+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets;
+ (instancetype)alphabetWithSymbols:(NSString *)string;

- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (instancetype)initWithStrings:(NSArray *)strings;
- (instancetype)initWithSymbols:(NSString *)strings;

-(NSUInteger)count;
-(NSString *)stringAtIndex:(NSUInteger)index;

-(id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
