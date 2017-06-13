//
//  IDPGCDWrap.m
//  Objc Task7
//
//  Created by Student002 on 6/9/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPGCDWrapper.h"

// dispatch asynchronous queues
static void IDPDispatchAsyncOnGlobalQueue(unsigned int priority, IDPBlock block) {
    dispatch_async(dispatch_get_global_queue(priority, 0), block);
}

void IDPDispatchAsyncOnMainQueue(IDPBlock block) {
    dispatch_async(dispatch_get_main_queue(), block);
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

static void IDPDispatchSyncOnGlobalQueue(unsigned int priority, IDPBlock block) {
    dispatch_sync(dispatch_get_global_queue(priority, 0), block);
}

void IDPDispatchSyncOnMainQueue(IDPBlock block) {
    dispatch_sync(dispatch_get_main_queue(), block);
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
