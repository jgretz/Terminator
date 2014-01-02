//
//  Terminator.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "Terminator.h"
#import "SquareCam.h"
#import "FaceDetector.h"
#import "CameraRoll.h"
#import "ImageCapture.h"
#import "FaceLibrary.h"

@interface Terminator()

@property (strong) SquareCam* squareCam;
@property (strong) FaceDetector* faceDetector;

@end

@implementation Terminator

const double ageFilter = 1;
const double faceDetectionInterval = .5;

-(void) startup {
    [[FaceLibrary object] registerForNewFaceNotification: ^(FaceCapture* capture) {

    }];

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

        [self.faceDetector detectFaces: capture];
    };

    [self performSelector: @selector(detectFaces) withObject: nil afterDelay: faceDetectionInterval];
}

@end
