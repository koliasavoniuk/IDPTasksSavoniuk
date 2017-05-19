//
//  IDPDirector.m
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPDirector.h"

#import "IDPAccountant.h"

@implementation IDPDirector

- (void)performWorkWithObject:(IDPAccountant *)object {
    [self calculateProfit];
}

- (void)calculateProfit {
    NSLog(@"%@ calculated profit, I have %lu$", self.name, self.money);
}

@end
