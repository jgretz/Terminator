//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.

#import "FaceDetection.h"
#import "ImageCapture.h"
#import "FaceCapture.h"
#import "OpenCVFaceRecognition.h"

@interface FaceDetection()

@end

@implementation FaceDetection

-(NSArray*) detectFaces: (ImageCapture*) capture {
    NSDictionary* options = @{ CIDetectorAccuracy : CIDetectorAccuracyLow };
    CIDetector* detector = [CIDetector detectorOfType: CIDetectorTypeFace context: nil options: options];

    NSArray* features = [detector featuresInImage: capture.image options: @{ CIDetectorImageOrientation : @6 }]; // 0th row is on the right, and 0th column is the top
    if (features.count == 0)
        return @[];

    // capture the faces in the image
    NSMutableArray* faces = [NSMutableArray array];
    for (CIFaceFeature* face in features) {
        // crop and rotate
        CIImage* workingImage = [[capture.image imageByCroppingToRect: face.bounds] imageByApplyingTransform: CGAffineTransformMakeRotation((CGFloat) (-90 * M_PI/ 180))];

        // save
        CIContext* context = [CIContext contextWithOptions: nil];
        CGImageRef passThrough = [context createCGImage: workingImage fromRect: workingImage.extent];

        FaceCapture* faceCapture = [FaceCapture object];
        faceCapture.faceImage = [UIImage imageWithCGImage: passThrough];
        faceCapture.captured = capture.captured;

        [faces addObject: faceCapture];
    }

    return faces;
}

@end