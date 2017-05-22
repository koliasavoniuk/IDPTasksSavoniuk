//
//  IDPAlphabet.m
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <math.h>

#import "IDPAlphabet.h"

#import "IDPRangeAlphabet.h"
#import "IDPClusterAlphabet.h"
#import "IDPStringsAlphabet.h"

#import "NSString+IDPExtensions.h"

NSRange IDPMakeAlphabetRange(unichar firstChar, unichar secondChar) {
    unichar minValue = MIN(firstChar, secondChar);
    unichar maxValue = MAX(firstChar, secondChar);
    
    return NSMakeRange(minValue, maxValue - minValue + 1);
}

@interface IDPAlphabet ()
@property (nonatomic, assign) NSUInteger  count;

@end
@implementation IDPAlphabet

#pragma mark -
#pragma mark Class Methods

+ (instancetype)numericAlphabet {
    return [self alphabetWithRange:IDPMakeAlphabetRange('0', '9')];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [self alphabetWithRange:IDPMakeAlphabetRange('a', 'z')];
}

+ (instancetype)capitalizedLetterAlphabet {
    return [self alphabetWithRange:IDPMakeAlphabetRange('A', 'Z')];
}

+ (instancetype)letterAlphabet {
    NSArray *alphabets = [NSArray arrayWithObjects:[self lowercaseLetterAlphabet],
                          [self capitalizedLetterAlphabet],
                          nil];
    
    return [self alphabetWithAlphabets:alphabets];
}

+ (instancetype)alphanumericAlphabet {
    NSArray *alphabets = [NSArray arrayWithObjects:[self letterAlphabet],
                          [self numericAlphabet],
                          nil];
    
    return [self alphabetWithAlphabets:alphabets];
}

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[IDPRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[IDPRangeAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets {
    return [[[IDPClusterAlphabet alloc] initWithAlphabets:alphabets] autorelease];
}

+ (instancetype)alphabetWithSymbols:(NSString *)string {
    return [self alphabetWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [super dealloc];
}

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    return [[IDPRangeAlphabet alloc] initWithRange:range];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    return [[IDPClusterAlphabet alloc] initWithAlphabets:alphabets];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    return [[IDPStringsAlphabet alloc] initWithStrings:strings];
}

- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}



#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self stringAtIndex:index];
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString stringWithCapacity:self.count];
    
    for (NSString *symbol in self) {
        [string appendString:symbol];
    }
    
    return [[string copy] autorelease];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])stackbuf
                                    count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    if (0 != resultLength) {
        for (NSUInteger index = 0; index < resultLength; index++) {
            stackbuf[index] = self[index + state->state];
        }
    }
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
