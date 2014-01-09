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
#import "CameraRoll.h"

@interface SquareCam()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong) AVCaptureSession* session;
@property AVCaptureDevicePosition currentCameraPosition;

@end


@implementation SquareCam {
    NSDate* lastTaken;
}

const float throttle = .1;

#pragma mark - Start / Stop
-(void) startCapturing {
    [self setupAVCapture];

    [self.session startRunning];
}

-(void) stopCapturing {
    [self.session stopRunning];
}

-(void) setupAVCapture {
    NSError* error = nil;

    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset: AVCaptureSessionPreset640x480];

    // Select a video device, make an input
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    AVCaptureDeviceInput* deviceInput = [AVCaptureDeviceInput deviceInputWithDevice: device error: &error];
    if (error)
        return;

    self.currentCameraPosition = device.position;


    if ([self.session canAddInput: deviceInput])
        [self.session addInput: deviceInput];

    // Make a video data output
    AVCaptureVideoDataOutput* videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];

    // we want BGRA, both CoreGraphics and OpenGL work well with 'BGRA'
    NSDictionary* rgbOutputSettings = [NSDictionary dictionaryWithObject: [NSNumber numberWithInt: kCMPixelFormat_32BGRA] forKey: (id) kCVPixelBufferPixelFormatTypeKey];
    [videoDataOutput setVideoSettings: rgbOutputSettings];
    [videoDataOutput setAlwaysDiscardsLateVideoFrames: YES]; // discard if the data output queue is blocked (as we process the still image)

    // create a serial dispatch queue used for the sample buffer delegate
    // a serial dispatch queue must be used to guarantee that video frames will be delivered in order
    dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [videoDataOutput setSampleBufferDelegate: self queue: videoDataOutputQueue];

    if ([self.session canAddOutput: videoDataOutput])
        [self.session addOutput: videoDataOutput];
    [[videoDataOutput connectionWithMediaType: AVMediaTypeVideo] setEnabled: YES];
}

#pragma mark - Control
-(void) useCameraPosition: (AVCaptureDevicePosition) devicePosition {
    [self.session stopRunning];

    for (AVCaptureDeviceInput* device in self.session.inputs)
        [self.session removeInput: device];

    AVCaptureDevice* device = nil;
    for (AVCaptureDevice* potential in [AVCaptureDevice devicesWithMediaType: AVMediaTypeVideo]) {
        if (potential.position == devicePosition) {
            device = potential;
            break;
        }
    }

    if (!device)
        return;

    NSError* error;
    AVCaptureDeviceInput* deviceInput = [AVCaptureDeviceInput deviceInputWithDevice: device error: &error];
    if (error)
        return;

    if ([self.session canAddInput: deviceInput])
        [self.session addInput: deviceInput];
    [self.session startRunning];

    self.currentCameraPosition = devicePosition;
}

#pragma mark - Events
-(void) captureOutput: (AVCaptureOutput*) captureOutput didOutputSampleBuffer: (CMSampleBufferRef) sampleBuffer fromConnection: (AVCaptureConnection*) connection {
    if (lastTaken && [[NSDate date] timeIntervalSinceDate: lastTaken] < throttle)
        return;
    lastTaken = [NSDate date];

    // got an image
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    CIImage* ciImage = [[[CIImage alloc] initWithCVPixelBuffer: pixelBuffer options: (__bridge NSDictionary*) attachments] imageByApplyingTransform: CGAffineTransformMakeRotation((CGFloat) (-90 * M_PI/ 180))];
    if (attachments)
        CFRelease(attachments);

    if (!ciImage)
        return;

    [[CameraRoll object] pushImage: ciImage];
}

@end
