//
//  IDPStringExtensionTest.m
//  IDPTask4
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPStringExtensionTest.h"

#import "IDPRandom.h"

#import "NSString+IDPExtensions.h"

static NSUInteger kIDPStringLength = 50;

#pragma mark -
#pragma mark Private Declaration

static
void IDPStringExtensionTesting();

#pragma mark -
#pragma mark Public Implementations

void IDPStringExtensionTest() {
    IDPStringExtensionTesting();
}

#pragma mark -
#pragma mark Private Declarations

void IDPStringExtensionTesting() {
    NSLog(@"%@", [NSString randomString]);
    NSLog(@"%@", [NSString randomStringWithLength:kIDPStringLength]);
    NSLog(@"%@", [NSString randomStringWithLength:kIDPStringLength alphabet:[NSString numericAlphabet]]);
    NSLog(@"%@", [NSString randomStringWithLength:kIDPStringLength alphabet:[NSString alphanumericAlphabet]]);
    NSLog(@"%@", [NSString randomStringWithLength:kIDPStringLength alphabet:[NSString lowercaseLetterAlphabet]]);
}
