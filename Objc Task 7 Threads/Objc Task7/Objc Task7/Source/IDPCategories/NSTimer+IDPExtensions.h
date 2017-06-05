//
//  NSTimer+IDPExtensions.h
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPTimerProxy;

@interface NSTimer (IDPExtensions)

+ (NSTimer *)scheduledTimerWithInterval:(NSTimeInterval)seconds
                                 target:(id)target
                               selector:(SEL)selector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats;
@end
