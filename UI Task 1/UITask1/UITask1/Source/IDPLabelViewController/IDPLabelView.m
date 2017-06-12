//
//  IDPLabelView.m
//  UITask1
//
//  Created by Student002 on 6/12/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPLabelView.h"

@implementation IDPLabelView

#pragma mark -
#pragma mark Public

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.label.text = @"TTRS";
}

- (void)rotateLabel {
    self.label.transform =  CGAffineTransformMakeRotation((float)arc4random() / UINT32_MAX * 2 * M_2_PI);
}

@end
