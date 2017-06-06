//
//  IDPTimerProxy.m
//  Objc Task7
//
//  Created by Student002 on 6/5/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPTimerProxy.h"

@interface IDPTimerProxy ()
@property (nonatomic, assign)   id      target;
@property (nonatomic, assign)   SEL     selector;

@end

@implementation IDPTimerProxy

#pragma mark -
#pragma mark Class Methods

+ (instancetype)timerWithTarget:(id)target
                       selector:(SEL)selector
{
    return [[[self alloc] initWithTarget:target
                                selector:selector] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.target = nil;
    
    [super dealloc];
}

- (instancetype)initWithTarget:(id)target
                      selector:(SEL)selector
{
    self = [super init];
    
    self.target = target;
    self.selector = selector;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)onTimer:(NSTimer *)timer {
    [self.target performSelector:self.selector withObject:timer];
}

@end
