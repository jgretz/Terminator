//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>
#import "TerminatorBase.h"

@interface Body : TerminatorBase

@property (nonatomic, readonly) BOOL hasBase;

-(void) startup;
-(void) shutdown;

-(void) turnRight;
-(void) turnLeft;
-(void) goForward;
-(void) goBackward;
-(void) stopDriving;
-(void) tiltForward;
-(void) tiltBackward;
-(void) stopTilt;
-(void) toggleLED;

@end