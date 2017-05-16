//
//  IDPMale.m
//  IDPTask2
//
//  Created by Student002 on 5/8/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPMale.h"

@implementation IDPMale

- (void)fight {
    NSLog(@"%@Fight!!!", self.name);
}

- (void)performGenderSpecificOperation {
    [self fight];
}

@end
