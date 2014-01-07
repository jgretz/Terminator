//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.

#import "FaceDetection.h"
#import "ImageCapture.h"
#import "FaceCapture.h"

@interface FaceDetection()

@end

@implementation FaceDetection

-(NSArray*) detectFaces: (ImageCapture*) capture {
    CIDetector* detector = [CIDetector detectorOfType: CIDetectorTypeFace context: nil options: @{ CIDetectorAccuracy : CIDetectorAccuracyLow }];

    NSArray* features = [detector featuresInImage: capture.image options: @{ CIDetectorImageOrientation : @1 }];
    if (features.count == 0)
        return @[];

    // capture the faces in the image
    NSMutableArray* faces = [NSMutableArray array];
    for (CIFaceFeature* face in features) {
        // crop
        CIImage* workingImage = [capture.image imageByCroppingToRect: face.bounds];

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