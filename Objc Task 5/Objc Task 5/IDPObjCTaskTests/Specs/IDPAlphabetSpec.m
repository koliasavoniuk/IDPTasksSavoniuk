//
//  IDPAlphabetSpec.m
//  Objc Task 5
//
//  Created by Student002 on 5/17/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "Kiwi.h"

#import "IDPAlphabet.h"
#import "IDPRangeAlphabet.h"
#import "IDPClusterAlphabet.h"
#import "IDPStringsAlphabet.h"

SPEC_BEGIN(IDPAlphabetSpec)

describe(@"IDPAlphabet", ^{
    __block IDPAlphabet *alphabet = nil;
    /*
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
     
     */
    
    afterEach(^{
        alphabet = nil;
    });
    
    context(@"when initialized with +alphabetWithRange: with range 'A'-'B'", ^{
        beforeAll(^{
            alphabet = [IDPAlphabet alphabetWithRange:NSMakeRange('A', 'B' - 'A')];
        });
        
        it(@"should be of class IDPRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPRangeAlphabet class]];
        });
        
        it(@"should be of count 2", ^{
//            [[theValue([alphabet count]) should] equal:@(2)];
            [[alphabet should] haveCountOf:2];
        });
        
        it(@"should contain @\"A\" at index = 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain @\"B\" at index = 1", ^{
            [[alphabet[1] should] equal:@"B"];
        });
    });
    
    context(@"when initialized with -initWithRange: with range 'A'-'B'", ^{        
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithRange:NSMakeRange('A', 'B' - 'A')];
        });
        
        it(@"should be of class IDPRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPRangeAlphabet class]];
        });
    });
});

SPEC_END
