//
//  NSString+IDPExtensions.m
//  IDPTask4
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSString+IDPExtensions.h"

#import "IDPRandom.h"

static const NSUInteger kIDPStringDefaultRandomStringLength = 25;

static NSRange IDPAlphabetRange(char loc, char len) {
    NSUInteger min = MIN(loc, len);
    NSUInteger max = MAX(loc, len);
    
    return NSMakeRange(min, max - min + 1 );
}

@implementation NSString (IDPExtension)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)numericAlphabet {
    return [self alphabetWithUnicodeRange:IDPAlphabetRange('0', '9')];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:IDPAlphabetRange('a', 'z')];
}

+ (instancetype)capitalizedLetterAlphabet {
    return [self alphabetWithUnicodeRange:IDPAlphabetRange('A', 'Z')];
}

+ (instancetype)alphanumericAlphabet {
    NSString *result = [self letterAlphabet];
    
    return [result stringByAppendingString:[self numericAlphabet]];
}

+ (instancetype)letterAlphabet {
    NSString *result = [self lowercaseLetterAlphabet];

    return [result stringByAppendingString:[self capitalizedLetterAlphabet]];
}

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar character = range.location; character < NSMaxRange(range); character++) {
        [result appendFormat:@"%c", character];
    }
    
    return [self stringWithString:result];
}

+ (instancetype)randomString {
    return [self randomStringWithLength:IDPRandomTillNumber(kIDPStringDefaultRandomStringLength)];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[self alphanumericAlphabet]];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength = [alphabet length];
    
    for (NSUInteger index = 0; index < length; index++) {
        unichar resultChar = [alphabet characterAtIndex:IDPRandomTillNumber(alphabetLength - 1)];
        [result appendFormat:@"%c", resultChar];
    }
    
    return [self stringWithString:result];
}

@end
