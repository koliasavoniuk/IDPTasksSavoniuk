//
//  IDPTimerProxy.h
//  Objc Task7
//
//  Created by Student002 on 6/5/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPTimerProxy : NSObject
@property (nonatomic, readonly)   id      target;
@property (nonatomic, readonly)   SEL     selector;

+ (instancetype)timerWithTarget:(id)target selector:(SEL)selector;

- (instancetype)initWithTarget:(id)target selector:(SEL)selector;

- (void)onTimer:(NSTimer *)timer;

@end
