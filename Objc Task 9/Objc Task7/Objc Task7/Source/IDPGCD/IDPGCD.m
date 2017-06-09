//
//  IDPGCD.m
//  Objc Task7
//
//  Created by Student002 on 6/9/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPGCD.h"

static const uint32_t IDPUsecondsInSecond = 1000 * 1000;
static const uint32_t IDPMaxSleepDuration = 1;
static const size_t   kIDPIterationCount  = 500;

static NSString * const kIDPGCDQueue      = @"kIDPGCDQueue";

@interface IDPGCD ()
@property (nonatomic, assign) NSUInteger        sleepCount;
@property (nonatomic, assign) NSUInteger        wakeUpCount;
@property (nonatomic, retain) dispatch_queue_t  queue;

- (void)executeWithQueueType:(dispatch_queue_attr_t)attribute;

@end

@implementation IDPGCD

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(dispatch_queue_t)queue {
    if (queue != _queue) {
        if (_queue) {
            dispatch_release(_queue);
        }
        
        _queue = queue;
        
        if (queue) {
            dispatch_retain(queue);
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)executeSerial {
    [self executeWithQueueType:DISPATCH_QUEUE_SERIAL];
}

- (void)executeConcurrent {
    [self executeWithQueueType:DISPATCH_QUEUE_CONCURRENT];
}

#pragma mark -
#pragma mark Private Methods

- (void)executeWithQueueType:(dispatch_queue_attr_t)attribute {
    dispatch_queue_t queue = dispatch_queue_create([kIDPGCDQueue cStringUsingEncoding:NSUTF8StringEncoding],
                                                   attribute);
    self.queue = queue;
    dispatch_release(queue);
    
    dispatch_sync(queue, ^{
        dispatch_apply(kIDPIterationCount, queue, ^(size_t count){
            dispatch_sync(queue, ^{
                uint32_t time = arc4random_uniform(IDPUsecondsInSecond * IDPMaxSleepDuration);
                self.sleepCount += 1;
                
                NSTimeInterval sleepDuration = (float)time / IDPUsecondsInSecond;
                printf("ID = %lu, Sleep for %f seconds\n", count, sleepDuration);
                
                usleep(time);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    printf("ID = %lu,  Wake up after %f seconds\n", count, sleepDuration);
                    self.wakeUpCount += 1;
                });
            });
        });
    });
}

@end
