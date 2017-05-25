//
//  IDPObservableObject.h
//  Objc Task7
//
//  Created by Student002 on 5/25/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObserver.h"

@protocol IDPObservableObject <NSObject>
@property (nonatomic, readonly) NSArray *observers;

@optional
- (void)addObserver:(id)observer;
- (void)deleteObserver:(id)observer;
- (void)notifyObservers;

@end
