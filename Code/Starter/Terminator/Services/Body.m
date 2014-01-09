//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <RMCore/RMCore.h>
#import "Body.h"

@interface Body()<RMCoreDelegate>

@property (strong) RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol>* robot;

@end

@implementation Body

-(BOOL) hasBase {
    return self.robot != nil;
}

// RomoSetup

#pragma mark - Romo Control

// RomoMoves

@end