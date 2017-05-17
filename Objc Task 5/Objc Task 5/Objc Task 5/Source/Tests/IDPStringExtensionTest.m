//
//  IDPStringExtensionTest.m
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPStringExtensionTest.h"

#import "IDPRandom.h"

#import "NSString+IDPExtensions.h"

#pragma mark -
#pragma mar Private Declaration

static
void IDPRandomString();

#pragma mark -
#pragma mar Public Implementations

void IDPStringExtensionTest() {
    IDPRandomString();
}

#pragma mark -
#pragma mar PrivateDeclaretions

void IDPRandomString() {
    NSLog(@"%@", [NSString randomString]);
    NSLog(@"%@", [NSString randomStringWithLength:5]);
    NSLog(@"%@", [NSString randomStringWithLength:5 alphabet:[NSString numericAlphabet]]);
    
    SEL selectors[] = { @selector(alphanumericAlphabet),
        @selector(numericAlphabet),
        @selector(lowercaseLetterAlphabet),
        @selector(capitalizedLetterAlphabet),
        @selector(letterAlphabet)};
    
    NSUInteger count = sizeof(selectors) / sizeof(*selectors);
    id class = [NSString class];
    
    for (NSUInteger index = 0; index < count; index++) {
        NSLog(@"%@", [class performSelector:selectors[index]]);
    }
}
