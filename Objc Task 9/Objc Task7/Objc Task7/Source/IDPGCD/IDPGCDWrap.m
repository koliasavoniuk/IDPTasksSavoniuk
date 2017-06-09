//
//  IDPGCDWrap.m
//  Objc Task7
//
//  Created by Student002 on 6/9/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPGCDWrap.h"

void IDPExecuteConcurrentInBackgroundWithBlock(void(^block)()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
}

void IDPExecuteConcurrentOnMainWithBlock(void(^block)()) {
    dispatch_async(dispatch_get_main_queue(), block);
}
