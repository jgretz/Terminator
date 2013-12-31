//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import <AVFoundation/AVFoundation.h>
#import "Camera.h"

@interface Camera()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong) AVCaptureSession* avCaptureSession;

@end

@implementation Camera

-(AVCaptureDevice*) frontCamera {
    return [[AVCaptureDevice devicesWithMediaType: AVMediaTypeVideo] firstWhere: ^BOOL(AVCaptureDevice* device) {return device.position == AVCaptureDevicePositionFront;}];
}

-(AVCaptureDevice*) backCamera {
    return [[AVCaptureDevice devicesWithMediaType: AVMediaTypeVideo] firstWhere: ^BOOL(AVCaptureDevice* device) {return device.position == AVCaptureDevicePositionBack;}];
}

-(void) startCapturing {
    @synchronized (self) {
        if (!self.avCaptureSession) {
            // Define input / output
            AVCaptureDeviceInput* captureInput = [AVCaptureDeviceInput deviceInputWithDevice: self.frontCamera error: nil];
            AVCaptureVideoDataOutput* captureOutput = [[AVCaptureVideoDataOutput alloc] init];

            captureOutput.alwaysDiscardsLateVideoFrames = YES;

            dispatch_queue_t queue;
            queue = dispatch_queue_create("cameraQueue", NULL);
            [captureOutput setSampleBufferDelegate: self queue: queue];
            [captureOutput setVideoSettings: @{ (NSString*) kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt: kCVPixelFormatType_32BGRA] }];

            // create session
            self.avCaptureSession = [[AVCaptureSession alloc] init];
            self.avCaptureSession.sessionPreset = AVCaptureSessionPresetPhoto;
            [self.avCaptureSession addInput: captureInput];
            [self.avCaptureSession addOutput: captureOutput];
        }

        [self.avCaptureSession startRunning];
    }
}

-(void) stopCapturing {
    @synchronized (self) {
        [self.avCaptureSession stopRunning];
    }
}

-(void) captureOutput: (AVCaptureOutput*) captureOutput didOutputSampleBuffer: (CMSampleBufferRef) sampleBuffer fromConnection: (AVCaptureConnection*) connection {
    if (!self.onCaptureImage)
        return;

    @autoreleasepool {
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(imageBuffer, 0);

        uint8_t* baseAddress = (uint8_t*) CVPixelBufferGetBaseAddress(imageBuffer);
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        CGImageRef newImage = CGBitmapContextCreateImage(newContext);

        CGContextRelease(newContext);
        CGColorSpaceRelease(colorSpace);

        // TODO: fix image orientation
        UIImage* image = [UIImage imageWithCGImage: newImage scale: 1.0 orientation: UIImageOrientationRight];

        CGImageRelease(newImage);
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);

        self.onCaptureImage(image);
    }
}

@end