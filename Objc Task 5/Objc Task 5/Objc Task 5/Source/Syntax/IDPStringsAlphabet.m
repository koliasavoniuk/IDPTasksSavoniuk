//
//  IDPStringsAlphabet.m
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPStringsAlphabet.h"

@interface IDPStringsAlphabet ()
@property (nonatomic, retain)   NSArray *strings;

@end

@implementation IDPStringsAlphabet

#pragma Mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.strings = nil;
    
    [super dealloc];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    self = [super init];
    if (self) {
        self.strings = strings;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    return [self.strings count];
}

- (NSString *)stringAtIndex:(NSUInteger)index {
       return self.strings[index];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])stackbuf
                                    count:(NSUInteger)resultLength
{
    return [self.strings countByEnumeratingWithState:state
                                             objects:stackbuf
                                               count:resultLength];
}

@end
