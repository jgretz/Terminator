//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <RMCore/RMCore.h>
#import "Body.h"

@interface Body()<RMCoreDelegate>

@property (strong) RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol>* robot;

@end

@implementation Body

-(void) startup {
        [self speak: @"Romo Delegate Set"];
        [RMCore setDelegate: self];
}

-(void) shutdown {
}

#pragma mark - RMCoreDelegate
-(void) robotDidConnect: (RMCoreRobot*) robot {
    [self speak: @"Romo Base Connected"];
    self.robot = (RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol>*) robot;

    [self turnToTheRight];
}

-(void) robotDidDisconnect: (RMCoreRobot*) robot {
    [self speak: @"Romo Base Disonnected"];
    if (robot == self.robot)
        self.robot = nil;
}

#pragma mark - Romo Control
-(void) turnToTheRight {
    [self.robot turnByAngle: 90.0
                 withRadius: RM_DRIVE_RADIUS_TURN_IN_PLACE
                 completion: ^(float heading) {
                     NSLog(@"Finished! Ended up at heading: %f", heading);
                 }];
}

@end