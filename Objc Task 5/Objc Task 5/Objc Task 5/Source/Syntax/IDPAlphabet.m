//
//  IDPAlphabet.m
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPAlphabet.h"

#import "IDPRangeAlphabet.h"
#import "IDPClusterAlphabet.h"
#import "IDPStringsAlphabet.h"

#import "NSString+IDPExtensions.h"

NSRange IDPMakeAlphabetRange(unichar value1, unichar value2) {
    unichar minValue = MIN(value1, value2);
    unichar maxValue = MAX(value1, value2);
    
    return NSMakeRange(minValue, maxValue);
}

@implementation IDPAlphabet

#pragma mark -
#pragma mark NSArray

#pragma mark -
#pragma mark Class Methods

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[IDPRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[IDPRangeAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets {
    return [[[IDPRangeAlphabet alloc] initWithAlphabets:alphabets] autorelease];
}

+ (instancetype)alphabetWithSymbols:(NSString *)string {
    return [self alphabetWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    return [[[IDPRangeAlphabet alloc] initWithRange:range] autorelease];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    return [[[IDPClusterAlphabet alloc] initWithAlphabets:alphabets] autorelease];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    return [[[IDPStringsAlphabet alloc] initWithStrings:strings] autorelease];
}

- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}



#pragma mark -
#pragma mark Public

-(NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}
-(NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

-(id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self stringAtIndex:idx];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id  _Nullable [])buffer
                                    count:(NSUInteger)len {
    return 0;
}



@end
