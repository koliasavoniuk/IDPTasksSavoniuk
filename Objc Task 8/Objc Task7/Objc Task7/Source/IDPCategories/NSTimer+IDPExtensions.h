//
//  NSTimer+IDPExtensions.h
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPTimerProxy;

@interface NSTimer (IDPTimerExtension)

+ (nonnull NSTimer *)scheduledWeakReferenceTimerWithTimeInterval:(NSTimeInterval)ti
                                                          target:(nonnull id)aTarget
                                                        selector:(nonnull SEL)aSelector
                                                        userInfo:(nullable id)userInfo
                                                        repeats:(BOOL)yesOrNo;

@end
