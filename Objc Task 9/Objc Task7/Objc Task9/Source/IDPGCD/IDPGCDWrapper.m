//
//  IDPGCDWrap.m
//  Objc Task7
//
//  Created by Student002 on 6/9/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPGCDWrapper.h"

extern void IDPTimerDispatch(NSUInteger timeInterval, IDPBlock block) {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC);
    dispatch_after(popTime, IDPDispatchGetGlobalQueue(QOS_CLASS_BACKGROUND, 0), block);
}

dispatch_queue_t IDPDispatchGetGlobalQueue(qos_class_t priority, unsigned long flags) {
    return dispatch_get_global_queue(priority, flags);
}

void IDPDispatch_async(qos_class_t priority, unsigned long flags, IDPBlock block) {
    dispatch_async(IDPDispatchGetGlobalQueue(priority, flags), block);
}

// dispatch asynchronous queues
static void IDPDispatchAsyncOnGlobalQueue(qos_class_t priority, IDPBlock block) {
    IDPDispatch_async(priority, 0, block);
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
    IDPDispatch_async(priority, 0, block);
}

void IDPDispatchSyncOnMainQueue(IDPBlock block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
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
