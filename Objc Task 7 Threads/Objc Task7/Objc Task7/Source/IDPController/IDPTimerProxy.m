//
//  IDPTimerProxy.m
//  Objc Task7
//
//  Created by Student002 on 6/5/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPTimerProxy.h"
#import "NSTimer+IDPExtensions.h"

@implementation IDPTimerProxy

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.target = nil;
    
    [super dealloc];
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    self = [super init];
    self.target = target;
    self.selector = selector;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)onTimer:(NSTimer *)timer {
    [self.target performSelector:self.selector];
}

@end
