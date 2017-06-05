//
//  NSTimer+IDPExtensions.m
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSTimer+IDPExtensions.h"

#import "IDPTimerProxy.h"

@implementation NSTimer (IDPExtensions)

+ (NSTimer *)scheduledTimerWithInterval:(NSTimeInterval)seconds
                                 target:(id)target
                               selector:(SEL)selector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats {
    IDPTimerProxy *proxy = [[[IDPTimerProxy alloc] initWithTarget:target
                                                         selector:selector] autorelease];
    
    return [self scheduledTimerWithTimeInterval:seconds
                                         target:proxy
                                       selector:@selector(onTimer:)
                                       userInfo:userInfo
                                        repeats:repeats];
}

@end
