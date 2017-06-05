//
//  NSTimer+IDPExtensions.m
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "NSTimer+IDPExtensions.h"

#import "IDPTimerProxy.h"

#import "NSObject+IDPExtensions.h"

@implementation NSTimer (IDPTimerExtention)

+ (nonnull NSTimer *)scheduledWeakReferenceTimerWithTimeInterval:(NSTimeInterval)ti
                                                      target:(nonnull id)aTarget
                                                    selector:(nonnull SEL)aSelector
                                                    userInfo:(nullable id)userInfo
                                                     repeats:(BOOL)yesOrNo {
    IDPTimerProxy *weakReferenceTimer = [IDPTimerProxy timerWithTarget:aTarget selector:aSelector];
    
    return [NSTimer scheduledTimerWithTimeInterval:ti
                                            target:weakReferenceTimer
                                          selector:@selector(onTimer:)
                                          userInfo:userInfo
                                           repeats:yesOrNo];
}

@end
