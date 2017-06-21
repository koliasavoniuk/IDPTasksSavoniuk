//
//  IDPGCDWrap.m
//  Objc Task7
//
//  Created by Student002 on 6/9/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPGCDWrapper.h"

static dispatch_queue_t IDPDispatchGetGlobalQueue(qos_class_t priority) {
    return dispatch_get_global_queue(priority, 0);
}

void IDPDispatchAsyncInBackgroundWithInterval(NSTimeInterval interval,
                                              IDPBlock block,
                                              IDPRunBlock running)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC),
                   IDPDispatchGetGlobalQueue(QOS_CLASS_BACKGROUND), ^{
                       if (running()) {
                           block();
                           IDPDispatchAsyncInBackgroundWithInterval(interval, block, running);
                       }
                   });
}

void IDPDispatchOnMainQueue(IDPBlock block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

// dispatch asynchronous queues
static void IDPDispatchAsyncOnGlobalQueue(qos_class_t priority, IDPBlock block) {
    dispatch_async(IDPDispatchGetGlobalQueue(priority), block);
}

void IDPDispatchAsyncInBackground(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_BACKGROUND, block);
}

void IDPDispatchAsyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_UTILITY, block);
}

void IDPDispatchAsyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_USER_INITIATED, block);
}

void IDPDispatchAsyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_USER_INTERACTIVE, block);
}

void IDPDispatchAsyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_DEFAULT, block);
}

// dispatch synchronous queues
static void IDPDispatchSyncOnGlobalQueue(qos_class_t priority, IDPBlock block) {
    dispatch_sync(IDPDispatchGetGlobalQueue(priority), block);
}

void IDPDispatchSyncInBackground(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_BACKGROUND, block);
}

void IDPDispatchSyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_UTILITY, block);
}

void IDPDispatchSyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_USER_INITIATED, block);
}

void IDPDispatchSyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_USER_INTERACTIVE, block);
}

void IDPDispatchSyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_DEFAULT, block);
}
