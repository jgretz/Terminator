//
//  AppDelegate.m
//  terminator
//
//  Created by Joshua Gretz on 10/27/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerConfiguration.h"
#import "MainVC.h"

@implementation AppDelegate

-(BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions {
    [ContainerConfiguration configure];

    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [MainVC object];

    [self.window makeKeyAndVisible];
    return YES;
}

-(void) applicationWillResignActive: (UIApplication*) application {
}

-(void) applicationDidBecomeActive: (UIApplication*) application {
}

@end
