//
//  NSString+IDPExtensions.h
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPRandom.h"

@interface NSString (IDPExtension)

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range;

+ (instancetype)randomString;

+ (instancetype)randomStringWithLength:(NSUInteger)length;

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

- (NSArray *)symbols;

@end
