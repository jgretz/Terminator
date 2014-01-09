//
// Created by Joshua Gretz on 1/8/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "BaseVC.h"


@implementation BaseVC

-(void) viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
}

@end