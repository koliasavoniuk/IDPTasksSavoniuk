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
    
    afterAll(^{
        alphabet = nil;
    });
    
    context(@"when initialized with +alphabetWithRange: with range 'A'-'B'", ^{
        beforeAll(^{
            alphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('A', 'B')];
        });
        
        it(@"should be of class IDPRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPRangeAlphabet class]];
        });
        
        it(@"should be of count 2", ^{
            [[alphabet should] haveCountOf:2];
        });
        
        it(@"should contain @\"A\" at index = 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain @\"B\" at index = 1", ^{
            [[alphabet[1] should] equal:@"B"];
        });
        
        it(@"should throw, when requesting object at index 3", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:3];
            }) should] raise];
            
            [[theBlock(^{
                id a = alphabet[3];
                [a description];
            }) should] raise];
        });
        
        it(@"should return @\"AB\" from -string", ^{
            [[[alphabet string] should] equal:@"AB"];
        });
        
    });
    
    context(@"when initialized with -initWithRange: with range 'A'-'B'", ^{        
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithRange:IDPMakeAlphabetRange('A', 'B')];
        });
        
        it(@"should be of class IDPRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPRangeAlphabet class]];
        });
    });
    
    context(@"when initialized with +initWithRange: with range 'A'-'z' when enumerated", ^{
        NSRange range = IDPMakeAlphabetRange('A', 'B');
        
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithRange:range];
        });
        
        it(@"shouldn't raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A'-'z' range", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:@(range.length)];
        });
        
        it(@"should return symbols in range 'A'-'z'", ^{
            unichar character = range.location;
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                character++;
            }
        });
    });

    context(@"when initialized with +alphabetWithStrings: with @[@\"a\", @\"b\"]", ^{
        beforeAll(^{
            alphabet = [IDPAlphabet alphabetWithStrings:@[@"a", @"b"]];
        });
        
        it(@"should be of class IDPStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPStringsAlphabet class]];
        });
        
        it(@"should be of count 2", ^{
            [[alphabet should] haveCountOf:2];
        });
        
        it(@"should contain @\"a\" at index = 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"a"];
        });
        
        it(@"should contain @\"b\" at index = 1", ^{
            [[alphabet[1] should] equal:@"b"];
        });
        
        it(@"should throw, when requesting object at index 3", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:3];
            }) should] raise];
            
            [[theBlock(^{
                id a = alphabet[3];
                [a description];
            }) should] raise];
        });
        
        it(@"should return @\"ab\" from -string", ^{
            [[[alphabet string] should] equal:@"ab"];
        });
        
    });
    
    context(@"when initialized with -initWithStrings: with @[@\"a\", @\"b\"]", ^{
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithStrings:@[@"a", @"b"]];
        });
        
        it(@"should be of class IDPStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPStringsAlphabet class]];
        });
    });
    
    context(@"when initialized with +initWithStrings: with array containing 'A'-'z' when enumerated", ^{
        NSRange range = IDPMakeAlphabetRange('A', 'B');
        NSMutableArray *strings = [NSMutableArray new];
        
        beforeAll(^{
            for (unichar symbol = range.location; symbol < NSMaxRange(range); symbol++) {
                [strings addObject:[NSString stringWithFormat:@"%c", symbol]];
            }
            
            alphabet = [[IDPAlphabet alloc] initWithStrings:strings];
        });
        
        it(@"shouldn't raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A'-'z' range", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:@(range.length)];
        });
        
        it(@"should return symbols in range 'A'-'z'", ^{
            unichar character = range.location;
            
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                character++;
            }
        });
    });
    
    context(@"when initialized with +alphabetWitAlphabets: in range 'A'-'Z', 'a'-'z']", ^{
        IDPAlphabet *capitalizedAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('A', 'Z')];
        IDPAlphabet *lowercaseAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('a', 'z')];
        
        beforeAll(^{
            alphabet = [IDPAlphabet alphabetWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"should be of class IDPClusterAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPClusterAlphabet class]];
        });
        
        it(@"should be of count 52", ^{
            [[alphabet should] haveCountOf:52];
        });
        
        it(@"should throw, when requesting object at index 53", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:53];
            }) should] raise];
            
            [[theBlock(^{
                id a = alphabet[53];
                [a description];
            }) should] raise];
        });
        
        it(@"should return @\"A-Za-z\" from -string", ^{
            NSString *string = [NSString stringWithFormat:@"%@%@",
                                [capitalizedAlphabet string],
                                 [lowercaseAlphabet string]];
            [[[alphabet string] should] equal:string];
        });
        
    });
    
    context(@"when initialized with -initWithAlphabets: in range 'A'-'Z', 'a'-'z']", ^{
        IDPAlphabet *capitalizedAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('A', 'Z')];
        IDPAlphabet *lowercaseAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('a', 'z')];
        
        beforeAll(^{
            alphabet = [[IDPClusterAlphabet alloc] initWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];;
        });
        
        it(@"should be of class IDPClusterAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPClusterAlphabet class]];
        });
    });
    
    context(@"when initialized with +initWithStrings: with array containing 'A'-'z' when enumerated", ^{
        NSRange capitalizedRange = IDPMakeAlphabetRange('A', 'Z');
        NSRange lowercaseRange = IDPMakeAlphabetRange('a', 'z');
        
        IDPAlphabet *capitalizedAlphabet = [IDPAlphabet alphabetWithRange:capitalizedRange];
        IDPAlphabet *lowercaseAlphabet = [IDPAlphabet alphabetWithRange:lowercaseRange];
        
        beforeAll(^{
            alphabet = [[IDPClusterAlphabet alloc] initWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];;
        });
        
        it(@"shouldn't raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A'-'Z'+'a'-'z' range", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:@([capitalizedAlphabet count] + [lowercaseAlphabet count])];
        });
        
        it(@"should return symbols in range 'A'-'z'+'a'-'z'", ^{
            NSMutableString *string = [NSMutableString stringWithString:[capitalizedAlphabet string]];
            [string appendString:[lowercaseAlphabet string]];
            NSUInteger index = 0;
            
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", [string characterAtIndex:index]]];
                index++;
            }
        });
    });
});

SPEC_END
