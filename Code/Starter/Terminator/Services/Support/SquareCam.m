//
//  SquareCam.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//
//  Based on Apple's SquareCam example program: https://developer.apple.com/library/ios/samplecode/SquareCam/Introduction/Intro.html

#import <AVFoundation/AVFoundation.h>
#import "SquareCam.h"
#import "ImageCapture.h"
#import "CameraRoll.h"

@interface SquareCam()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong) AVCaptureSession* session;
@property AVCaptureDevicePosition currentCameraPosition;

@end


@implementation SquareCam

#pragma mark - Start / Stop
-(void) startCapturing {
    [self setupAVCapture];

    [self.session startRunning];
}

-(void) stopCapturing {
    [self.session stopRunning];
}

-(void) setupAVCapture {
    // CameraSetup
}

#pragma mark - Control
-(void) useCameraPosition: (AVCaptureDevicePosition) devicePosition {
    // CameraPosition
}

#pragma mark - Events
-(void) captureOutput: (AVCaptureOutput*) captureOutput didOutputSampleBuffer: (CMSampleBufferRef) sampleBuffer fromConnection: (AVCaptureConnection*) connection {
    // CameraOutput
}

@end
