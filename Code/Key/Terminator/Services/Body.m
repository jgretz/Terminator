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
    [RMCore setDelegate: self];
}

-(void) shutdown {
}

-(BOOL) hasBase {
    return self.robot != nil;
}

#pragma mark - RMCoreDelegate
-(void) robotDidConnect: (RMCoreRobot*) robot {
    self.robot = (RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol>*) robot;

    [self speak: @"Romo Base Connected"];
    [self.robot.LEDs turnOff];
}

-(void) robotDidDisconnect: (RMCoreRobot*) robot {
    [self speak: @"Romo Base Disonnected"];
    if (robot == self.robot)
        self.robot = nil;
}

-(void) tryToFindRobot {
    for (RMCoreRobot* robot in [RMCore connectedRobots])
        self.robot = (RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol>*) robot;
    [self.robot.LEDs turnOff];

    if (!self.robot)
        [self speak: @"No Robot Could Be Found"];
}

#pragma mark - Romo Control
-(void) turnRight {
    if (!self.robot)
        [self tryToFindRobot];
    
    [self.robot turnByAngle: -45.0
                 withRadius: RM_DRIVE_RADIUS_TURN_IN_PLACE
            finishingAction: RMCoreTurnFinishingActionStopDriving
                 completion:^(BOOL success, float heading) {
                 }];
}

-(void) turnLeft {
    if (!self.robot)
        [self tryToFindRobot];

    [self.robot turnByAngle: 45.0
                 withRadius: RM_DRIVE_RADIUS_TURN_IN_PLACE
            finishingAction: RMCoreTurnFinishingActionStopDriving
                 completion:^(BOOL success, float heading) {
                 }];
}

-(void) goForward {
    if (!self.robot)
        [self tryToFindRobot];

    [self.robot driveForwardWithSpeed: 1];
}

-(void) goBackward {
    if (!self.robot)
        [self tryToFindRobot];

    [self.robot driveBackwardWithSpeed: 1];
}

-(void) stopDriving {
    [self.robot stopDriving];

}

-(void) tiltForward {
    [self.robot tiltWithMotorPower: 1];
}

-(void) tiltBackward {
    [self.robot tiltWithMotorPower: -1];
}

-(void) stopTilt {
    [self.robot stopTilting];
}

-(void) toggleLED {
    if (!self.robot)
        [self tryToFindRobot];

    if (self.robot.LEDs.mode == RMCoreLEDModeSolid)
        [self.robot.LEDs turnOff];
    else
        [self.robot.LEDs setSolidWithBrightness: 1];
}

@end