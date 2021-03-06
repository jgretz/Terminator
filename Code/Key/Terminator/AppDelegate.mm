//
//  AppDelegate.m
//  terminator
//
//  Created by Joshua Gretz on 10/27/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerConfiguration.h"
#import "TerminatorVC.h"
#import "KnownPeopleVC.h"
#import "NamelessMassesVC.h"
#import "Terminator.h"
#import "AdminVC.h"

@implementation AppDelegate

-(BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions {
    [ContainerConfiguration configure];

    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UITabBarController* tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[ [[UINavigationController alloc] initWithRootViewController: [TerminatorVC object]],
                             [[UINavigationController alloc] initWithRootViewController: [KnownPeopleVC object]],
                             [[UINavigationController alloc] initWithRootViewController: [NamelessMassesVC object]],
                             [[UINavigationController alloc] initWithRootViewController: [AdminVC object]]
    ];

    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];

    [[Terminator object] startup];

    return YES;
}

@end
