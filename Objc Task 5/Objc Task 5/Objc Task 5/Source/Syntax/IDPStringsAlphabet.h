//
//  IDPStringsAlphabet.h
//  Objc Task 5
//
//  Created by Student002 on 5/15/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPAlphabet.h"

@interface IDPStringsAlphabet : IDPAlphabet
@property (nonatomic, readonly)   NSArray *strings;

- (instancetype)initWithStrings:(NSArray *)strings;

@end
