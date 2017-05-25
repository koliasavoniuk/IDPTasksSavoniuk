//
//  IDPObserver.h
//  Objc Task7
//
//  Created by Student002 on 5/25/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"

@protocol IDPObserver <NSObject>

@optional
- (void)performWorkWithObservableObject:(id)observableObject;

@end
