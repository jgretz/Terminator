//
//  Terminator.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "Terminator.h"
#import "SquareCam.h"
#import "FaceDetection.h"
#import "CameraRoll.h"
#import "ImageCapture.h"
#import "FaceIdentifier.h"

@interface Terminator()

@property (strong) SquareCam* squareCam;
@property (strong) FaceDetection* faceDetection;

@end

@implementation Terminator

const double ageFilter = 1;
const double faceDetectionInterval = .5;

-(void) startup {
    [[FaceIdentifier object] train];

    [self.squareCam startCapturing];
    [self.squareCam useCameraPosition: AVCaptureDevicePositionFront];

    [self performSelector: @selector(detectFaces) withObject: nil afterDelay: faceDetectionInterval];
}

-(void) shutdown {
    [self.squareCam stopCapturing];
}

-(void) detectFaces {
    NSArray* images = [[CameraRoll object] pop];

    for (ImageCapture* capture in images) {
        if ([[NSDate date] timeIntervalSinceDate: capture.captured] > ageFilter)
            continue;

        [self.faceDetection detectFaces: capture];
    };

    [self performSelector: @selector(detectFaces) withObject: nil afterDelay: faceDetectionInterval];
}

@end
