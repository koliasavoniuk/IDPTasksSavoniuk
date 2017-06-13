//
//  IDPQueue.h
//  Objc Task7
//
//  Created by Student002 on 6/2/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPQueue : NSObject
@property (nonatomic, readonly, getter=isEmpty)  BOOL    empty;

- (void)pushObject:(id)object;
- (id)popObject;
- (BOOL)isEmpty;

@end