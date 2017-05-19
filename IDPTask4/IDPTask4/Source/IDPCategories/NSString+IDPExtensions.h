//
//  NSString+IDPExtensions.h
//  IDPTask4
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPExtensions)

+ (instancetype)alphanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)lowercaseLetterAlphabet;
+ (instancetype)capitalizedLetterAlphabet;
+ (instancetype)letterAlphabet;
+ (instancetype)alphabetWithUnicodeRange:(NSRange)range;

+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

@end
