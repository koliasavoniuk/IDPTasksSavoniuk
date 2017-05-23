//
//  IDPRangeAlphabet.m
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPRangeAlphabet.h"

@interface IDPRangeAlphabet ()
@property (nonatomic, assign) NSRange range;

@end

@implementation IDPRangeAlphabet

#pragma mark -
#pragma mark Initializations and Deallocation

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    self.range = range;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    return self.range.length;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    NSRange range = self.range;
    
    NSAssert(index < range.length, NSRangeException);
    
    return [NSString stringWithFormat:@"%c", (unichar)(range.location + index)];
}

@end
