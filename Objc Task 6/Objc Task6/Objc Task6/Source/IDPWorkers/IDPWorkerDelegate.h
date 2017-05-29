//
//  IDPWorkerDelegate.h
//  Objc Task6
//
//  Created by Student002 on 5/23/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPWorkerDelegate <NSObject>

@optional
- (void)workerDidBecomeReadyForWork:(id)worker;
- (void)workerDidBecomeBusy:(id)worker;

@required
- (void)workerDidBecomeReadyForProcessing:(id)worker;

@end
