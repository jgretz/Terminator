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

// RomoSetup

// RomoMoves

#pragma mark - To Remove - here to cut down warnings
-(void) robotDidConnect: (RMCoreRobot*) robot {
}
-(void) robotDidDisconnect: (RMCoreRobot*) robot {
}
-(void) turnRight {
}
-(void) turnLeft {
}
-(void) goForward {
}
-(void) goBackward {
}
-(void) stopDriving {
}
-(void) tiltForward {
}
-(void) tiltBackward {
}
-(void) stopTilt {
}
-(void) toggleLED {
}
@end