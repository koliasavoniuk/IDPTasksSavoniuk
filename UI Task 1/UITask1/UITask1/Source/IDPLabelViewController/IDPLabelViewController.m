//
//  IDPLabelViewController.m
//  UITask1
//
//  Created by Student002 on 6/12/17.
//  Copyright © 2017 Student002. All rights reserved.
//

#import "IDPLabelViewController.h"

#import "IDPLabelView.h"

@interface IDPLabelViewController ()
@property (nonatomic, readonly) IDPLabelView    *labelView;

@end

@implementation IDPLabelViewController

#pragma mark -
#pragma mark Accessors

- (IDPLabelView *)labelView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[IDPLabelView class]]) {
        return (IDPLabelView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onRotateButton:(id)sender {
    [self.labelView rotateLabel];
}

@end
