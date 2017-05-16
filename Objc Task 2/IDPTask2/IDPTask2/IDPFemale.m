//
//  IDPFemale.m
//  IDPTask2
//
//  Created by Student002 on 5/8/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPFemale.h"

@implementation IDPFemale

-(void)giveBirth{
    NSLog(@"%@I made a children!!!", self.name);
}

- (void) performGenderSpecificOperation {
    [self giveBirth];
}

@end
