//
//  IDPFemale.m
//  IDPTask2
//
//  Created by Student002 on 5/8/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPFemale.h"

#import "NSObject+IDPCategory.h"

@implementation IDPFemale

- (IDPHuman *)child {
    NSLog(@"%@ I made children!!!", self.name);
    
    return [IDPHuman object];
}

- (void)performGenderSpecificOperation {
    [self child];
}

@end
