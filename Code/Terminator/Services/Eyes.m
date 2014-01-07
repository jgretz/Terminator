//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <AVFoundation/AVFoundation.h>
#import "Eyes.h"
#import "SquareCam.h"

@interface Eyes()

@property (strong) SquareCam* squareCam;

@end

@implementation Eyes

-(void) startup {
    [self.squareCam startCapturing];
    [self.squareCam useCameraPosition: AVCaptureDevicePositionFront];
}

-(void) shutdown {
    [self.squareCam stopCapturing];
}

@end