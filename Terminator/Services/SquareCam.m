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

@interface SquareCam()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong) AVCaptureSession* session;
@property (strong) CIDetector* faceDetector;
@property AVCaptureDevicePosition currentCameraPosition;

@end


@implementation SquareCam

#pragma mark - Start / Stop
-(void) startCapturing {
    [self setupAVCapture];

    [self.session startRunning];
}

-(void) stopCapturing {
    [self teardownAVCapture];

    [self.session stopRunning];
}

-(void) setupAVCapture {
    NSError* error = nil;

    self.session = [[AVCaptureSession alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [self.session setSessionPreset: AVCaptureSessionPreset640x480];
    else
        [self.session setSessionPreset: AVCaptureSessionPresetPhoto];

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

    // create a serial dispatch queue used for the sample buffer delegate as well as when a still image is captured
    // a serial dispatch queue must be used to guarantee that video frames will be delivered in order
    // see the header doc for setSampleBufferDelegate:queue: for more information
    dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [videoDataOutput setSampleBufferDelegate: self queue: videoDataOutputQueue];

    if ([self.session canAddOutput: videoDataOutput])
        [self.session addOutput: videoDataOutput];
    [[videoDataOutput connectionWithMediaType: AVMediaTypeVideo] setEnabled: YES];
}

-(void) teardownAVCapture {
}

#pragma mark - Control
-(void) useCamera: (AVCaptureDevicePosition) devicePosition {
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
    // got an image
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    CIImage* ciImage = [[CIImage alloc] initWithCVPixelBuffer: pixelBuffer options: (__bridge NSDictionary*) attachments];
    if (attachments)
        CFRelease(attachments);

    /* kCGImagePropertyOrientation values
        The intended display orientation of the image. If present, this key is a CFNumber value with the same value as defined
        by the TIFF and EXIF specifications -- see enumeration of integer constants.
        The value specified where the origin (0,0) of the image is located. If not present, a value of 1 is assumed.

        used when calling featuresInImage: options: The value for this key is an integer NSNumber from 1..8 as found in kCGImagePropertyOrientation.
        If present, the detection will be done based on that orientation but the coordinates in the returned features will still be based on those of the image. */

    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    int exifOrientation;
    enum {
        PHOTOS_EXIF_0ROW_TOP_0COL_LEFT = 1, //   1  =  0th row is at the top, and 0th column is on the left (THE DEFAULT).
        PHOTOS_EXIF_0ROW_TOP_0COL_RIGHT = 2, //   2  =  0th row is at the top, and 0th column is on the right.
        PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT = 3, //   3  =  0th row is at the bottom, and 0th column is on the right.
        PHOTOS_EXIF_0ROW_BOTTOM_0COL_LEFT = 4, //   4  =  0th row is at the bottom, and 0th column is on the left.
        PHOTOS_EXIF_0ROW_LEFT_0COL_TOP = 5, //   5  =  0th row is on the left, and 0th column is the top.
        PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP = 6, //   6  =  0th row is on the right, and 0th column is the top.
        PHOTOS_EXIF_0ROW_RIGHT_0COL_BOTTOM = 7, //   7  =  0th row is on the right, and 0th column is the bottom.
        PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM = 8  //   8  =  0th row is on the left, and 0th column is the bottom.
    };

    switch (curDeviceOrientation) {
        case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM;
            break;
        case UIDeviceOrientationLandscapeLeft:       // Device oriented horizontally, home button on the right
            if (self.currentCameraPosition == AVCaptureDevicePositionFront)
                exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
            else
                exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
            break;
        case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
            if (self.currentCameraPosition == AVCaptureDevicePositionFront)
                exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
            else
                exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
            break;
        case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
        default:
            exifOrientation = PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP;
            break;
    }

    NSArray* features = [self.faceDetector featuresInImage: ciImage options: @{ CIDetectorImageOrientation : [NSNumber numberWithInt:  exifOrientation] }];

    // get the clean aperture
    // the clean aperture is a rectangle that defines the portion of the encoded pixel dimensions
    // that represents image data valid for display.
    CMFormatDescriptionRef fdesc = CMSampleBufferGetFormatDescription(sampleBuffer);
    CGRect clap = CMVideoFormatDescriptionGetCleanAperture(fdesc, false /*originIsTopLeft == false*/);

    if (features.count > 0)
        NSLog(@"%i", features.count);

    self.mostRecentImage = [UIImage imageWithCIImage: ciImage scale: 1 orientation: (UIImageOrientation) curDeviceOrientation];

//    dispatch_async(dispatch_get_main_queue(), ^(void) {
//        [self drawFaceBoxesForFeatures: features forVideoBox: clap orientation: curDeviceOrientation];
//    });
}

@end
