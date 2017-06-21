//
//  IDPObservableObject.h
//  Objc Task7
//
//  Created by Student002 on 5/25/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPObservableObject : NSObject
@property (nonatomic, assign)    NSUInteger  state;
@property (nonatomic, readonly)  NSSet       *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)addObservers:(NSArray *)observers;
- (void)removeObservers:(NSArray *)observers;

- (SEL)selectorForState:(NSUInteger)state;
- (void)notifyOfState:(NSUInteger)state;

@end
