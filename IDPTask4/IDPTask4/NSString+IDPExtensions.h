//
//  NSString+IDPExtensions.h
//  IDPTask4
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPRandom.h"

@interface NSString (IDPExtensions)

+ (id)alphanumericAlphabet;
+ (id)numericAlphabet;
+ (id)lowercaseLetterAlphabet;
+ (id)capitalizedLetterAlphabet;
+ (id)letterAlphabet;

+ (id)alphabetWithUnicodeRange:(NSRange)range;

+ (id)randomString;

+ (id)randomStringWithLength:(NSUInteger)length;

+ (id)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

@end
