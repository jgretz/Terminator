//
//  AdminVC.m
//  Terminator
//
//  Created by Joshua Gretz on 1/7/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import "AdminVC.h"

@interface AdminVC()

@end

@implementation AdminVC

-(id) init {
    if ((self = [super init])) {
        self.title = @"Admin";
    }

    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;

    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems: @[ @"Images", @"Stats", @"Dance" ]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget: self action: @selector(setSelectedIndex:) forControlEvents: UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;

    [self setSelectedIndex: segmentedControl];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(imageAddedToCameraRoll:) name: [Constants ImageAddedToCameraRoll] object: nil];
}

-(void) setSelectedIndex: (UISegmentedControl*) segmentedControl {
    for (UIView* subView in self.view.subviews)
        subView.hidden = YES;
    [self.view.subviews[segmentedControl.selectedSegmentIndex] setHidden: NO];
}

-(void) imageAddedToCameraRoll: (NSNotification*) notification {
    [self.cameraImageView performSelectorOnMainThread: @selector(setImage:) withObject: notification.object waitUntilDone: NO];
}

@end
