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
#import "KnowledgeBaseVC.h"
#import "CaptureVC.h"
#import "Terminator.h"

@implementation AppDelegate

-(BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions {
    [ContainerConfiguration configure];

    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UITabBarController* tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[ [TerminatorVC object], [KnowledgeBaseVC object], [CaptureVC object] ];
    tbc.selectedIndex = 2;

    self.window.rootViewController = tbc;

    [self.window makeKeyAndVisible];
    return YES;
}

-(void) applicationDidBecomeActive: (UIApplication*) application {
    [[Terminator object] startup];
}

-(void) applicationWillResignActive: (UIApplication*) application {
    [[Terminator object] shutdown];
}

@end
