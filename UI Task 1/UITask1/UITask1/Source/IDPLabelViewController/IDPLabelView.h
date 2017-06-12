//
//  IDPLabelView.h
//  UITask1
//
//  Created by Student002 on 6/12/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPLabelView : UIView
@property   (nonatomic, strong) IBOutlet    UILabel     *label;
@property   (nonatomic, strong) IBOutlet    UIButton    *button;

- (void)rotateLabel;

@end
