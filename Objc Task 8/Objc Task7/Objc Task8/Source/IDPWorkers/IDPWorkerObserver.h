//
//  IDPWorkerObserver.h
//  Objc Task7
//
//  Created by Student002 on 6/5/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPWorkerObserver <NSObject>

@optional
- (void)workerDidBecomeFree:(id)worker;
- (void)workerDidBecomeBusy:(id)worker;
- (void)workerDidBecomeReadyForProcessing:(id)worker;

@end
