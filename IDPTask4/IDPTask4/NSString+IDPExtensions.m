//
//  NSString+IDPExtensions.m
//  IDPTask4
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSString+IDPExtensions.h"

#define NSUIntegerConstExtern(nameConstant) extern const Range nameConstant
#define NSUIntegerConst(nameConstant, value1, value2) const int nameConstant = value

static const NSUInteger kIDPStringDefaultRandomStringLength = 25;

static NSRange IDPAlphabetRange(char loc, char len) {
    NSUInteger min = MIN(loc, len);
    NSUInteger max = MAX(loc, len);
    return NSMakeRange(min, max - min + 1 );
}

@implementation NSString (IDPExtension)

#pragma mark -
#pragma mark Classes Methods

+ (id)numericAlphabet {
    return [self alphabetWithUnicodeRange:IDPAlphabetRange('0', '9')];
}

+ (id)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:IDPAlphabetRange('a', 'z')];
}

+ (id)capitalizedLetterAlphabet {
    return [self alphabetWithUnicodeRange:IDPAlphabetRange('A', 'Z')];
}

+ (id)alphanumericAlphabet {
    NSString *result = [self letterAlphabet];
    result = [result stringByAppendingString:[self numericAlphabet]];
    
    return result;
}

+ (id)letterAlphabet {
    NSString *result = [self lowercaseLetterAlphabet];
    result = [result stringByAppendingString:[self capitalizedLetterAlphabet]];
    
    return result;
}

+ (id)alphabetWithUnicodeRange:(NSRange)renge {
    NSMutableString *result = [NSMutableString string];
    for (unichar character = renge.location; character < NSMaxRange(renge); character++) {
        [result appendFormat:@"%c", character];
    }
    
    return [self stringWithString:result];
}

+ (id)randomString {
    return [self randomStringWithLength:IDPRandomTillNumber(kIDPStringDefaultRandomStringLength)];
}

+ (id)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[self alphanumericAlphabet]];
}

+ (id)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength = [alphabet length];
    
    for (NSUInteger index = 0; index < length; index++) {
        unichar resultChar = [alphabet characterAtIndex:IDPRandomTillNumber(alphabetLength)];
        [result appendFormat:@"%c",resultChar];
    }
    
    return [self stringWithString:result];
}

@end
